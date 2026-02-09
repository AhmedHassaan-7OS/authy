import 'package:flutter/material.dart';

class AuthToggle extends StatelessWidget {
  final String question;
  final String actionLabel;
  final VoidCallback onTap;
  const AuthToggle({
    super.key,
    required this.question,
    required this.actionLabel,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(question, style: theme.bodyMedium?.copyWith(color: const Color(0xff6C687F))),
        TextButton(
          onPressed: onTap,
          child: Text(actionLabel, style: const TextStyle(fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }
}
