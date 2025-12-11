import '../../data/models/user_model.dart';
import '../repositories/user_repository.dart';

class GetUserUseCase {
  final UserRepository repository;

  GetUserUseCase(this.repository);

  Future<UserModel?> call() async {
    return await repository.getUser();
  }
}
