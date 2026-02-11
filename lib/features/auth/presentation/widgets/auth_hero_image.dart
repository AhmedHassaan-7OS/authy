import 'package:motion_ai/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthHeroImage extends StatelessWidget {
  const AuthHeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffCBB7FF).withOpacity(0.25),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: SvgPicture.asset(
        AppAssets.authPlaceholderSvg,
        width: 240,
        height: 180,
        fit: BoxFit.contain,
      ),
    );
  }
}

