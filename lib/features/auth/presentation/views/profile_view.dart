import 'dart:typed_data';

import 'package:authy/core/constants/app_constants.dart';
import 'package:authy/features/auth/domain/entities/app_user.dart';
import 'package:authy/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:authy/features/auth/presentation/widgets/auth_card.dart';
import 'package:authy/features/auth/presentation/widgets/auth_header.dart';
import 'package:authy/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:authy/features/auth/presentation/widgets/auth_text_field.dart';
import 'package:authy/features/auth/presentation/widgets/avatar_picker.dart';
import 'package:authy/features/auth/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileView extends StatefulWidget {
  final AppUser user;
  const ProfileView({super.key, required this.user});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  Uint8List? avatarBytes;
  String? avatarExt;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.user.fullName ?? '');
    emailController = TextEditingController(text: widget.user.email);
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AuthScaffold(
      child: Column(
        children: [
          const SizedBox(height: 24),
          AuthCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const AuthHeader(
                  title: 'Your profile',
                  subtitle: 'Update your info and keep it fresh.',
                ),
                const SizedBox(height: 20),
                AvatarPicker(
                  avatarUrl: widget.user.avatarUrl,
                  onImageSelected: (bytes, ext) {
                    setState(() {
                      avatarBytes = bytes;
                      avatarExt = ext;
                    });
                  },
                ),
                const SizedBox(height: 20),
                AuthTextField(
                  label: 'Full name',
                  hint: 'Your name',
                  controller: nameController,
                ),
                const SizedBox(height: 16),
                AuthTextField(
                  label: 'Email',
                  hint: widget.user.email,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                PrimaryButton(
                  label: 'Update Profile',
                  onPressed: () {
                    context.read<AuthCubit>().updateProfile(
                          fullName: nameController.text.trim(),
                          avatarBytes: avatarBytes,
                          avatarExt: avatarExt,
                        );
                  },
                ),
                const SizedBox(height: 12),
                OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(52),
                    side: BorderSide(color: kPrimaryColor.withOpacity(0.3)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  onPressed: () => context.read<AuthCubit>().signOut(),
                  child: const Text('Sign out'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
