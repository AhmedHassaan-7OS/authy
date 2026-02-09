import 'package:authy/features/auth/domain/entities/app_user.dart';

abstract class AuthRepository {
  Future<AppUser?> getCurrentUser();
  Future<AppUser> signIn({required String email, required String password});
  Future<AppUser> signUp({
    required String fullName,
    required String email,
    required String password,
  });
  Future<void> signOut();
  Future<AppUser> updateProfile({String? fullName, String? avatarUrl});
  Future<String> uploadAvatar({required List<int> bytes, required String ext});
}
