import 'package:authy/features/auth/domain/entities/face_category.dart';
import 'package:authy/features/auth/domain/entities/face_classification_result.dart';
import 'package:authy/features/auth/presentation/widgets/auth_card.dart';
import 'package:authy/features/auth/presentation/widgets/auth_header.dart';
import 'package:authy/features/auth/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class HomeFaceClassifierCard extends StatelessWidget {
  final bool isLoading;
  final FaceClassificationResult? result;
  final String? errorMessage;
  final VoidCallback onPickImage;

  const HomeFaceClassifierCard({
    super.key,
    required this.isLoading,
    required this.result,
    required this.errorMessage,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    final hasError = errorMessage != null && errorMessage!.trim().isNotEmpty;
    return AuthCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthHeader(
            title: 'Face Classifier',
            subtitle: 'Classifies image into: boy, girl, or animal/other.',
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            label: isLoading ? 'Analyzing...' : 'Pick Image & Classify',
            onPressed: isLoading ? null : onPickImage,
          ),
          if (hasError) ...[
            const SizedBox(height: 12),
            Text(
              errorMessage!,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: const Color(0xffFFB4AB),
                  ),
            ),
          ],
          const SizedBox(height: 16),
          _FaceResultBox(result: result),
        ],
      ),
    );
  }
}

class _FaceResultBox extends StatelessWidget {
  final FaceClassificationResult? result;
  const _FaceResultBox({required this.result});

  @override
  Widget build(BuildContext context) {
    final text = result == null
        ? 'No classification yet.'
        : '${_labelFor(result!.category)} | Faces: ${result!.detectedFaces}\nHeuristic estimate only.';
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xD1181228),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x33FFFFFF)),
      ),
      child: Text(text, style: Theme.of(context).textTheme.bodyMedium),
    );
  }

  String _labelFor(FaceCategory category) {
    return switch (category) {
      FaceCategory.boy => 'Boy',
      FaceCategory.girl => 'Girl',
      FaceCategory.animalOrOther => 'Animal / Other',
    };
  }
}
