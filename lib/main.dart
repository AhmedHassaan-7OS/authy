import 'package:motion_ai/core/constants/supabase_keys.dart';
import 'package:motion_ai/core/theme/app_theme.dart';
import 'package:motion_ai/core/utils/service_locator.dart';
import 'package:motion_ai/features/auth/presentation/views/intro_launch_view.dart';
import 'package:flutter/material.dart';
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
      title: 'motion ai',
      theme: AppTheme.light,
      home: const IntroLaunchView(),
    );
  }
}
