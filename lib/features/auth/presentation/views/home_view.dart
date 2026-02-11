import 'package:authy/core/utils/service_locator.dart';
import 'package:authy/core/widgets/app_snackbar.dart';
import 'package:authy/features/auth/domain/entities/app_user.dart';
import 'package:authy/features/auth/presentation/cubit/ai_text_cubit.dart';
import 'package:authy/features/auth/presentation/cubit/ai_text_state.dart';
import 'package:authy/features/auth/presentation/views/profile_view.dart';
import 'package:authy/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:authy/features/auth/presentation/widgets/home_ai_scan_card.dart';
import 'package:authy/features/auth/presentation/widgets/home_profile_avatar_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomeView extends StatelessWidget {
  final AppUser user;

  const HomeView({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AiTextCubit>(),
      child: BlocConsumer<AiTextCubit, AiTextState>(
        listener: (context, state) {
          if (state.status == AiTextStatus.failure && state.errorMessage != null) {
            AppSnackBar.showError(context, state.errorMessage!);
          }
        },
        builder: (context, state) {
          return AuthScaffold(
            child: Column(
              children: [
                const SizedBox(height: 16),
                HomeProfileAvatarButton(
                  avatarUrl: user.avatarUrl,
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => ProfileView(user: user),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 20),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Welcome ${user.fullName?.trim().isNotEmpty == true ? user.fullName!.trim() : user.email}',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
                const SizedBox(height: 16),
                HomeAiScanCard(
                  isLoading: state.status == AiTextStatus.loading,
                  extractedText: state.extractedText,
                  onPickImage: () async {
                    final picker = ImagePicker();
                    final image = await picker.pickImage(
                      source: ImageSource.gallery,
                      imageQuality: 90,
                    );
                    if (image == null || !context.mounted) return;
                    await context.read<AiTextCubit>().extractFromImage(image.path);
                  },
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}
