import 'package:get_it/get_it.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:authy/features/auth/data/datasources/supabase_auth_remote_data_source.dart';
import 'package:authy/features/auth/data/datasources/supabase_auth_remote_data_source_impl.dart';
import 'package:authy/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:authy/features/auth/domain/repositories/auth_repository.dart';
import 'package:authy/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:authy/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:authy/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:authy/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:authy/features/auth/domain/usecases/update_profile_usecase.dart';
import 'package:authy/features/auth/domain/usecases/upload_avatar_usecase.dart';
import 'package:authy/features/auth/presentation/cubit/auth_cubit.dart';

final getIt = GetIt.instance;

Future<void> setupServiceLocator() async {
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  getIt.registerLazySingleton<AuthRemoteDataSource>(
    () => SupabaseAuthRemoteDataSource(getIt()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt()),
  );
  getIt.registerLazySingleton(() => SignInUseCase(getIt()));
  getIt.registerLazySingleton(() => SignUpUseCase(getIt()));
  getIt.registerLazySingleton(() => SignOutUseCase(getIt()));
  getIt.registerLazySingleton(() => UpdateProfileUseCase(getIt()));
  getIt.registerLazySingleton(() => UploadAvatarUseCase(getIt()));
  getIt.registerLazySingleton(() => GetCurrentUserUseCase(getIt()));

  getIt.registerFactory(
    () => AuthCubit(
      signIn: getIt(),
      signUp: getIt(),
      signOut: getIt(),
      updateProfile: getIt(),
      getCurrentUser: getIt(),
      uploadAvatar: getIt(),
    ),
  );
}
