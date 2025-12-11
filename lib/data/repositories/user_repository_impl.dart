import '../datasources/local/local_data_source.dart';
import '../datasources/remote/api_client.dart';
import '../models/user_model.dart';
import '../../domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiClient apiClient;
  final LocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.apiClient,
    required this.localDataSource,
  });

  @override
  Future<UserModel?> getUser() async {
    try {
      final response = await apiClient.getUserInfo();
      if (response['success'] == true) {
        return UserModel.fromJson(response['data']);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
