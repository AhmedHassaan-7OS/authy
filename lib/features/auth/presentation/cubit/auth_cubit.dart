import 'dart:typed_data';

import 'package:authy/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:authy/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:authy/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:authy/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:authy/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:authy/features/auth/domain/usecases/upload_avatar_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUseCase _signIn;
  final SignUpUseCase _signUp;
  final SignOutUseCase _signOut;
  final UpdateProfileUseCase _updateProfile;
  final GetCurrentUserUseCase _getCurrentUser;
  final UploadAvatarUseCase _uploadAvatar;

  AuthCubit({
    required SignInUseCase signIn,
    required SignUpUseCase signUp,
    required SignOutUseCase signOut,
    required UpdateProfileUseCase updateProfile,
    required GetCurrentUserUseCase getCurrentUser,
    required UploadAvatarUseCase uploadAvatar,
  })  : _signIn = signIn,
        _signUp = signUp,
        _signOut = signOut,
        _updateProfile = updateProfile,
        _getCurrentUser = getCurrentUser,
        _uploadAvatar = uploadAvatar,
        super(const AuthState());

  Future<void> loadCurrentUser() async {
    emit(state.copyWith(status: AuthStatus.loading, clearError: true));
    try {
      final user = await _getCurrentUser();
      if (user == null) {
        emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
      } else {
        emit(state.copyWith(status: AuthStatus.authenticated, user: user));
      }
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> signIn({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading, clearError: true));
    try {
      final user = await _signIn(email: email, password: password);
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> signUp({
    required String fullName,
    required String email,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, clearError: true));
    try {
      final user = await _signUp(fullName: fullName, email: email, password: password);
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> signOut() async {
    emit(state.copyWith(status: AuthStatus.loading, clearError: true));
    try {
      await _signOut();
      emit(state.copyWith(status: AuthStatus.unauthenticated, user: null));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()));
    }
  }

  Future<void> updateProfile({
    String? fullName,
    Uint8List? avatarBytes,
    String? avatarExt,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, clearError: true));
    try {
      String? avatarUrl;
      if (avatarBytes != null && avatarExt != null) {
        avatarUrl = await _uploadAvatar(bytes: avatarBytes, ext: avatarExt);
      }
      final user = await _updateProfile(fullName: fullName, avatarUrl: avatarUrl);
      emit(state.copyWith(status: AuthStatus.authenticated, user: user));
    } catch (e) {
      emit(state.copyWith(status: AuthStatus.failure, errorMessage: e.toString()));
    }
  }
}
