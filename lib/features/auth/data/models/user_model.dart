import 'package:motion_ai/features/auth/domain/entities/app_user.dart';
import 'package:equatable/equatable.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserModel extends AppUser with EquatableMixin {
  const UserModel({
    required super.id,
    required super.email,
    super.fullName,
    super.avatarUrl,
  });

  factory UserModel.fromSupabase(User user) {
    final meta = user.userMetadata ?? {};
    return UserModel(
      id: user.id,
      email: user.email ?? '',
      fullName: meta['full_name'] as String?,
      avatarUrl: meta['avatar_url'] as String?,
    );
  }
}

