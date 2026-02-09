import 'package:authy/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AuthHeroImage extends StatelessWidget {
  const AuthHeroImage({super.key});

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      AppAssets.authPlaceholderSvg,
      width: 240,
      height: 180,
      fit: BoxFit.contain,
    );
  }
}
