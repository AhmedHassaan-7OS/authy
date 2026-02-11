import 'package:motion_ai/features/auth/domain/repositories/auth_repository.dart';

class UploadAvatarUseCase {
  final AuthRepository _repo;
  UploadAvatarUseCase(this._repo);

  Future<String> call({required List<int> bytes, required String ext}) {
    return _repo.uploadAvatar(bytes: bytes, ext: ext);
  }
}

