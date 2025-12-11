abstract class AuthRepository {
  Future<bool> login(String phone);
  Future<bool> verifyCode(String phone, String code);
  Future<bool> verifyPassport({
    required String series,
    required String number,
    required String birthDate,
  });
  Future<void> logout();
  Future<bool> isAuthenticated();
}
