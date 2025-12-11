import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/datasources/local/local_data_source.dart';
import '../../data/datasources/remote/api_client.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/verify_code_usecase.dart';
import '../../domain/usecases/verify_passport_usecase.dart';
import '../../domain/usecases/get_user_usecase.dart';
import '../../presentation/blocs/auth/auth_bloc.dart';
import '../../presentation/blocs/theme/theme_bloc.dart';
import '../../presentation/blocs/locale/locale_bloc.dart';
import '../../presentation/blocs/user/user_bloc.dart';
import '../router/app_router.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureDependencies() async {
  // SharedPreferences
  final sharedPreferences = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(sharedPreferences);

  // Data Sources
  getIt.registerLazySingleton<LocalDataSource>(
    () => LocalDataSource(getIt<SharedPreferences>()),
  );

  getIt.registerLazySingleton<ApiClient>(
    () => ApiClient(),
  );

  // Repositories
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      apiClient: getIt<ApiClient>(),
      localDataSource: getIt<LocalDataSource>(),
    ),
  );

  getIt.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(
      apiClient: getIt<ApiClient>(),
      localDataSource: getIt<LocalDataSource>(),
    ),
  );

  // Use Cases
  getIt.registerLazySingleton(() => LoginUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => VerifyCodeUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(
      () => VerifyPassportUseCase(getIt<AuthRepository>()));
  getIt.registerLazySingleton(() => GetUserUseCase(getIt<UserRepository>()));

  // BLoCs
  getIt.registerFactory(() => AuthBloc(
        loginUseCase: getIt<LoginUseCase>(),
        verifyCodeUseCase: getIt<VerifyCodeUseCase>(),
        verifyPassportUseCase: getIt<VerifyPassportUseCase>(),
      ));

  getIt.registerFactory(() => UserBloc(
        getUserUseCase: getIt<GetUserUseCase>(),
      ));

  getIt.registerFactory(() => ThemeBloc(
        localDataSource: getIt<LocalDataSource>(),
      ));

  getIt.registerFactory(() => LocaleBloc(
        localDataSource: getIt<LocalDataSource>(),
      ));

  // Router
  getIt.registerSingleton<AppRouter>(AppRouter());
}
