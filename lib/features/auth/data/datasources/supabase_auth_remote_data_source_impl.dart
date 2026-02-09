import 'dart:typed_data';

import 'package:authy/core/constants/app_constants.dart';
import 'package:authy/features/auth/data/models/sign_in_model.dart';
import 'package:authy/features/auth/data/models/sign_up_model.dart';
import 'package:authy/features/auth/data/models/user_model.dart';
import 'package:authy/features/auth/domain/entities/app_user.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'supabase_auth_remote_data_source.dart';

class SupabaseAuthRemoteDataSource implements AuthRemoteDataSource {
  final SupabaseClient _client;
  SupabaseAuthRemoteDataSource(this._client);

  @override
  Future<AppUser?> getCurrentUser() async {
    final user = _client.auth.currentUser;
    if (user == null) return null;
    return UserModel.fromSupabase(user);
  }

  @override
  Future<AppUser> signIn(SignInModel model) async {
    final response = await _client.auth.signInWithPassword(
      email: model.email,
      password: model.password,
    );
    final user = response.user;
    if (user == null) {
      throw AuthException('Invalid credentials');
    }
    return UserModel.fromSupabase(user);
  }

  @override
  Future<AppUser> signUp(SignUpModel model) async {
    final response = await _client.auth.signUp(
      email: model.email,
      password: model.password,
      data: {'full_name': model.fullName},
    );
    final user = response.user;
    if (user == null) {
      throw AuthException('Unable to create account');
    }
    return UserModel.fromSupabase(user);
  }

  @override
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  @override
  Future<AppUser> updateProfile({String? fullName, String? avatarUrl}) async {
    final data = <String, dynamic>{};
    if (fullName != null) data['full_name'] = fullName;
    if (avatarUrl != null) data['avatar_url'] = avatarUrl;

    final response = await _client.auth.updateUser(
      UserAttributes(data: data.isEmpty ? null : data),
    );
    final user = response.user ?? _client.auth.currentUser;
    if (user == null) {
      throw AuthException('No user session');
    }
    return UserModel.fromSupabase(user);
  }

  @override
  Future<String> uploadAvatar({required Uint8List bytes, required String ext}) async {
    final user = _client.auth.currentUser;
    if (user == null) {
      throw AuthException('No user session');
    }

    final fileName = '${DateTime.now().millisecondsSinceEpoch}.$ext';
    final path = '${user.id}/$fileName';

    await _client.storage.from(kAvatarBucket).uploadBinary(
          path,
          bytes,
          fileOptions: FileOptions(contentType: 'image/$ext'),
        );

    return _client.storage.from(kAvatarBucket).getPublicUrl(path);
  }
}
