import 'dart:typed_data';

import 'package:authy/features/auth/data/models/sign_in_model.dart';
import 'package:authy/features/auth/data/models/sign_up_model.dart';
import 'package:authy/features/auth/domain/entities/app_user.dart';

abstract class AuthRemoteDataSource {
  Future<AppUser?> getCurrentUser();
  Future<AppUser> signIn(SignInModel model);
  Future<AppUser> signUp(SignUpModel model);
  Future<void> signOut();
  Future<AppUser> updateProfile({String? fullName, String? avatarUrl});
  Future<String> uploadAvatar({required Uint8List bytes, required String ext});
}
