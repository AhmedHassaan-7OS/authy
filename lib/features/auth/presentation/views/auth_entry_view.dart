import 'package:authy/core/constants/app_constants.dart';
import 'package:authy/features/auth/presentation/views/sign_in_view.dart';
import 'package:authy/features/auth/presentation/views/sign_up_view.dart';
import 'package:authy/features/auth/presentation/widgets/auth_card.dart';
import 'package:authy/features/auth/presentation/widgets/auth_hero_image.dart';
import 'package:authy/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:flutter/material.dart';

class AuthEntryView extends StatefulWidget {
  const AuthEntryView({super.key});

  @override
  State<AuthEntryView> createState() => _AuthEntryViewState();
}

class _AuthEntryViewState extends State<AuthEntryView> {
  bool isSignIn = true;

  void toggle() {
    setState(() => isSignIn = !isSignIn);
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        children: [
          const SizedBox(height: 16),
          const AuthHeroImage(),
          const SizedBox(height: 20),
          AuthCard(
            child: AnimatedSwitcher(
              duration: kTransitionDuration,
              child: isSignIn
                  ? SignInView(key: const ValueKey('signin'), onToggle: toggle)
                  : SignUpView(key: const ValueKey('signup'), onToggle: toggle),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class AuthEntryLoadingView extends StatelessWidget {
  const AuthEntryLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthScaffold(
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
