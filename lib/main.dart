import 'package:authy/core/constants/supabase_keys.dart';
import 'package:authy/core/theme/app_theme.dart';
import 'package:authy/core/utils/service_locator.dart';
import 'package:authy/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:authy/features/auth/presentation/views/auth_root_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: kSupabaseUrl,
    anonKey: kSupabaseAnonKey,
  );
  await setupServiceLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Authy',
      theme: AppTheme.light,
      home: BlocProvider(
        create: (_) => getIt<AuthCubit>()..loadCurrentUser(),
        child: const AuthRootView(),
      ),
    );
  }
}
