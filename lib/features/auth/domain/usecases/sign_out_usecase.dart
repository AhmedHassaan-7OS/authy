import 'package:authy/features/auth/domain/repositories/auth_repository.dart';

class SignOutUseCase {
  final AuthRepository _repo;
  SignOutUseCase(this._repo);

  Future<void> call() => _repo.signOut();
}
