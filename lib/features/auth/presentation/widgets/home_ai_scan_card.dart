import 'package:motion_ai/features/auth/presentation/widgets/auth_card.dart';
import 'package:motion_ai/features/auth/presentation/widgets/auth_header.dart';
import 'package:motion_ai/features/auth/presentation/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class HomeAiScanCard extends StatelessWidget {
  final bool isLoading;
  final String extractedText;
  final VoidCallback onPickImage;

  const HomeAiScanCard({
    super.key,
    required this.isLoading,
    required this.extractedText,
    required this.onPickImage,
  });

  @override
  Widget build(BuildContext context) {
    final hasResult = extractedText.trim().isNotEmpty;
    return AuthCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const AuthHeader(
            title: 'AI Text Scanner',
            subtitle: 'Pick an image and let ML Kit extract text for you.',
          ),
          const SizedBox(height: 20),
          PrimaryButton(
            label: isLoading ? 'Scanning...' : 'Pick Image & Scan',
            onPressed: isLoading ? null : onPickImage,
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xff181228).withOpacity(0.82),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0x33FFFFFF)),
            ),
            child: Text(
              hasResult ? extractedText : 'No extracted text yet.',
              maxLines: 10,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}

