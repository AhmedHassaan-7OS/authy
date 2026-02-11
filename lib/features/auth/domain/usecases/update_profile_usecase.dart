import 'package:motion_ai/features/auth/domain/entities/app_user.dart';
import 'package:motion_ai/features/auth/domain/repositories/auth_repository.dart';

class UpdateProfileUseCase {
  final AuthRepository _repo;
  UpdateProfileUseCase(this._repo);

  Future<AppUser> call({String? fullName, String? avatarUrl}) {
    return _repo.updateProfile(fullName: fullName, avatarUrl: avatarUrl);
  }
}

