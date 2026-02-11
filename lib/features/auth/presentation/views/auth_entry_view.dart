import 'package:motion_ai/core/constants/app_constants.dart';
import 'package:motion_ai/features/auth/presentation/views/sign_in_view.dart';
import 'package:motion_ai/features/auth/presentation/views/sign_up_view.dart';
import 'package:motion_ai/features/auth/presentation/widgets/auth_card.dart';
import 'package:motion_ai/features/auth/presentation/widgets/auth_hero_image.dart';
import 'package:motion_ai/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:motion_ai/core/widgets/app_loader.dart';
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
          TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 700),
            curve: Curves.easeOutCubic,
            tween: Tween(begin: 0, end: 1),
            builder: (context, value, child) {
              return Opacity(
                opacity: value,
                child: Transform.translate(
                  offset: Offset(0, (1 - value) * 18),
                  child: child,
                ),
              );
            },
            child: AuthCard(
              child: AnimatedSwitcher(
                duration: kTransitionDuration,
                child: isSignIn
                    ? SignInView(key: const ValueKey('signin'), onToggle: toggle)
                    : SignUpView(key: const ValueKey('signup'), onToggle: toggle),
              ),
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
          child: AppLoader(label: 'Loading your space...'),
        ),
      ),
    );
  }
}

