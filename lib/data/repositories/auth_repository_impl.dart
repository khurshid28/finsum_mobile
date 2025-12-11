import '../datasources/local/local_data_source.dart';
import '../datasources/remote/api_client.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiClient apiClient;
  final LocalDataSource localDataSource;

  AuthRepositoryImpl({
    required this.apiClient,
    required this.localDataSource,
  });

  @override
  Future<bool> login(String phone) async {
    try {
      final response = await apiClient.login(phone);
      return response['success'] == true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> verifyCode(String phone, String code) async {
    try {
      final response = await apiClient.verifyCode(phone, code);
      if (response['success'] == true) {
        final token = response['data']['token'];
        final userId = response['data']['user_id'];
        await localDataSource.saveToken(token);
        await localDataSource.saveUserId(userId);
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<bool> verifyPassport({
    required String series,
    required String number,
    required String birthDate,
  }) async {
    try {
      final response = await apiClient.verifyPassport(
        series: series,
        number: number,
        birthDate: birthDate,
      );
      return response['success'] == true;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> logout() async {
    await localDataSource.deleteToken();
    await localDataSource.deleteUserId();
  }

  @override
  Future<bool> isAuthenticated() async {
    final token = localDataSource.getToken();
    return token != null && token.isNotEmpty;
  }
}
