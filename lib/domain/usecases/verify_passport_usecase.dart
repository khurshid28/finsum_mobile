import '../repositories/auth_repository.dart';

class VerifyPassportUseCase {
  final AuthRepository repository;

  VerifyPassportUseCase(this.repository);

  Future<bool> call({
    required String series,
    required String number,
    required String birthDate,
  }) async {
    return await repository.verifyPassport(
      series: series,
      number: number,
      birthDate: birthDate,
    );
  }
}
