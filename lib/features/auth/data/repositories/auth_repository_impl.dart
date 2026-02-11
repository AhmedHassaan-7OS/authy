import 'dart:typed_data';

import 'package:motion_ai/features/auth/data/datasources/supabase_auth_remote_data_source.dart';
import 'package:motion_ai/features/auth/data/models/sign_in_model.dart';
import 'package:motion_ai/features/auth/data/models/sign_up_model.dart';
import 'package:motion_ai/features/auth/domain/entities/app_user.dart';
import 'package:motion_ai/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource _remote;
  AuthRepositoryImpl(this._remote);

  @override
  Future<AppUser?> getCurrentUser() => _remote.getCurrentUser();

  @override
  Future<AppUser> signIn({required String email, required String password}) {
    return _remote.signIn(SignInModel(email: email, password: password));
  }

  @override
  Future<AppUser> signUp({
    required String fullName,
    required String email,
    required String password,
  }) {
    return _remote.signUp(
      SignUpModel(fullName: fullName, email: email, password: password),
    );
  }

  @override
  Future<void> signOut() => _remote.signOut();

  @override
  Future<AppUser> updateProfile({String? fullName, String? avatarUrl}) {
    return _remote.updateProfile(fullName: fullName, avatarUrl: avatarUrl);
  }

  @override
  Future<String> uploadAvatar({required List<int> bytes, required String ext}) {
    return _remote.uploadAvatar(bytes: Uint8List.fromList(bytes), ext: ext);
  }
}

