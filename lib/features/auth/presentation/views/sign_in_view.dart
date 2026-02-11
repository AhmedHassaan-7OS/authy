import 'package:motion_ai/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:motion_ai/features/auth/presentation/widgets/auth_header.dart';
import 'package:motion_ai/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:motion_ai/features/auth/presentation/widgets/auth_toggle.dart';
import 'package:motion_ai/features/auth/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInView extends StatefulWidget {
  final VoidCallback onToggle;
  const SignInView({super.key, required this.onToggle});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const AuthHeader(
          title: 'Welcome back',
          subtitle: 'Sign in to continue your experience.',
        ),
        const SizedBox(height: 20),
        AuthTextField(
          label: 'Email',
          hint: 'you@example.com',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        AuthTextField(
          label: 'Password',
          hint: '********',
          controller: passwordController,
          obscure: true,
        ),
        const SizedBox(height: 20),
        PrimaryButton(
          label: 'Sign In',
          onPressed: () {
            context.read<AuthCubit>().signIn(
                  email: emailController.text.trim(),
                  password: passwordController.text,
                );
          },
        ),
        const SizedBox(height: 12),
        AuthToggle(
          question: 'New here?',
          actionLabel: 'Create account',
          onTap: widget.onToggle,
        ),
      ],
    );
  }
}

