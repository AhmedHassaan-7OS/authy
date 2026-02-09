import 'package:authy/features/auth/domain/entities/app_user.dart';
import 'package:authy/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUseCase {
  final AuthRepository _repo;
  GetCurrentUserUseCase(this._repo);

  Future<AppUser?> call() => _repo.getCurrentUser();
}
