import 'package:authy/features/auth/domain/entities/app_user.dart';
import 'package:authy/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase {
  final AuthRepository _repo;
  SignInUseCase(this._repo);

  Future<AppUser> call({required String email, required String password}) {
    return _repo.signIn(email: email, password: password);
  }
}
