import '../repositories/auth_repository.dart';

class VerifyCodeUseCase {
  final AuthRepository repository;

  VerifyCodeUseCase(this.repository);

  Future<bool> call(String phone, String code) async {
    return await repository.verifyCode(phone, code);
  }
}
