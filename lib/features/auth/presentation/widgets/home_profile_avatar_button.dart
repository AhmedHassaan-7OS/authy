import 'package:authy/core/constants/app_constants.dart';
import 'package:authy/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeProfileAvatarButton extends StatelessWidget {
  final String? avatarUrl;
  final VoidCallback onTap;

  const HomeProfileAvatarButton({
    super.key,
    required this.avatarUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Transform.translate(
      offset: const Offset(0, -10),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: const Color(0x66CBB7FF)),
            boxShadow: [
              BoxShadow(
                color: kPrimaryColor.withValues(alpha: 0.35),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 24,
            backgroundColor: const Color(0xffE7E0FF),
            child: ClipOval(
              child: avatarUrl == null
                  ? SvgPicture.asset(
                      AppAssets.authPlaceholderSvg,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                    )
                  : Image.network(
                      avatarUrl!,
                      width: 48,
                      height: 48,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => SvgPicture.asset(
                        AppAssets.authPlaceholderSvg,
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
