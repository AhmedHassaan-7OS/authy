import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final String? label;
  const AppLoader({super.key, this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          width: 40,
          height: 40,
          child: CircularProgressIndicator(strokeWidth: 3),
        ),
        if (label != null) ...[
          const SizedBox(height: 12),
          Text(label!, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ],
    );
  }
}
