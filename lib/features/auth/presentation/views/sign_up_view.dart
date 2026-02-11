import 'package:motion_ai/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:motion_ai/features/auth/presentation/widgets/auth_header.dart';
import 'package:motion_ai/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:motion_ai/features/auth/presentation/widgets/auth_toggle.dart';
import 'package:motion_ai/features/auth/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpView extends StatefulWidget {
  final VoidCallback onToggle;
  const SignUpView({super.key, required this.onToggle});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
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
          title: 'Create your account',
          subtitle: 'We keep things fast, minimal, and secure.',
        ),
        const SizedBox(height: 20),
        AuthTextField(
          label: 'Full name',
          hint: 'Ahmed Ali',
          controller: nameController,
        ),
        const SizedBox(height: 16),
        AuthTextField(
          label: 'Email',
          hint: 'you@example.com',
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        AuthTextField(
          label: 'Password',
          hint: 'Create a password',
          controller: passwordController,
          obscure: true,
        ),
        const SizedBox(height: 20),
        PrimaryButton(
          label: 'Create Account',
          onPressed: () {
            context.read<AuthCubit>().signUp(
                  fullName: nameController.text.trim(),
                  email: emailController.text.trim(),
                  password: passwordController.text,
                );
          },
        ),
        const SizedBox(height: 12),
        AuthToggle(
          question: 'Already have an account?',
          actionLabel: 'Sign in',
          onTap: widget.onToggle,
        ),
      ],
    );
  }
}

