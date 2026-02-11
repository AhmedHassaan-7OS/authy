import 'package:motion_ai/features/auth/domain/entities/app_user.dart';
import 'package:motion_ai/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase {
  final AuthRepository _repo;
  SignUpUseCase(this._repo);

  Future<AppUser> call({
    required String fullName,
    required String email,
    required String password,
  }) {
    return _repo.signUp(fullName: fullName, email: email, password: password);
  }
}

