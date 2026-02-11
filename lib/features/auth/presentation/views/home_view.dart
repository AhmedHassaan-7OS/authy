import 'package:authy/core/utils/service_locator.dart';
import 'package:authy/core/widgets/app_snackbar.dart';
import 'package:authy/features/auth/domain/entities/app_user.dart';
import 'package:authy/features/auth/presentation/cubit/ai_text_cubit.dart';
import 'package:authy/features/auth/presentation/cubit/ai_text_state.dart';
import 'package:authy/features/auth/presentation/cubit/face_classifier_cubit.dart';
import 'package:authy/features/auth/presentation/cubit/face_classifier_state.dart';
import 'package:authy/features/auth/presentation/views/profile_view.dart';
import 'package:authy/features/auth/presentation/widgets/auth_scaffold.dart';
import 'package:authy/features/auth/presentation/widgets/home_ai_scan_card.dart';
import 'package:authy/features/auth/presentation/widgets/home_face_classifier_card.dart';
import 'package:authy/features/auth/presentation/widgets/home_profile_avatar_button.dart';
import 'package:authy/features/auth/presentation/widgets/floating_capsule_bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class HomeView extends StatefulWidget {
  final AppUser user;

  const HomeView({super.key, required this.user});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _selectedIndex = 0;
  final ImagePicker _picker = ImagePicker();
  late final AiTextCubit _aiTextCubit;
  late final FaceClassifierCubit _faceClassifierCubit;

  @override
  void initState() {
    super.initState();
    _aiTextCubit = getIt<AiTextCubit>();
    _faceClassifierCubit = getIt<FaceClassifierCubit>();
  }

  @override
  void dispose() {
    _aiTextCubit.close();
    _faceClassifierCubit.close();
    super.dispose();
  }

  Future<void> _openProfile() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ProfileView(user: widget.user),
      ),
    );
  }

  Future<void> _pickForTextScan() async {
    final image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 90);
    if (image == null || !mounted) return;
    await _aiTextCubit.extractFromImage(image.path);
  }

  Future<void> _pickForFaceClassifier() async {
    final image = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 90);
    if (image == null || !mounted) return;
    await _faceClassifierCubit.classifyFromImage(image.path);
  }

  String _welcomeName() {
    final name = widget.user.fullName?.trim() ?? '';
    return name.isNotEmpty ? name : widget.user.email;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _aiTextCubit),
        BlocProvider.value(value: _faceClassifierCubit),
      ],
      child: MultiBlocListener(
        listeners: [
          BlocListener<AiTextCubit, AiTextState>(
            listener: (context, state) {
              if (state.status == AiTextStatus.failure && state.errorMessage != null) {
                AppSnackBar.showError(context, state.errorMessage!);
              }
            },
          ),
          BlocListener<FaceClassifierCubit, FaceClassifierState>(
            listener: (context, state) {
              if (state.status == FaceClassifierStatus.failure && state.errorMessage != null) {
                AppSnackBar.showError(context, state.errorMessage!);
              }
            },
          ),
        ],
        child: Builder(
          builder: (context) {
            return AuthScaffold(
              centerContent: false,
              floatingBottomBar: FloatingCapsuleBottomNav(
                selectedIndex: _selectedIndex,
                onHomeTap: () => setState(() => _selectedIndex = 0),
                onFaceTap: () => setState(() => _selectedIndex = 1),
              ),
              child: Column(
                children: [
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      HomeProfileAvatarButton(
                        avatarUrl: widget.user.avatarUrl,
                        onTap: _openProfile,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Welcome ${_welcomeName()}',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  if (_selectedIndex == 0) ...[
                    BlocBuilder<AiTextCubit, AiTextState>(
                      builder: (context, state) {
                        return HomeAiScanCard(
                          isLoading: state.status == AiTextStatus.loading,
                          extractedText: state.extractedText,
                          onPickImage: _pickForTextScan,
                        );
                      },
                    ),
                  ] else ...[
                    BlocBuilder<FaceClassifierCubit, FaceClassifierState>(
                      builder: (context, state) {
                        return HomeFaceClassifierCard(
                          isLoading: state.status == FaceClassifierStatus.loading,
                          result: state.result,
                          onPickImage: _pickForFaceClassifier,
                          errorMessage:
                              state.status == FaceClassifierStatus.failure ? state.errorMessage : null,
                        );
                      },
                    ),
                  ],
                  const SizedBox(height: 110),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
