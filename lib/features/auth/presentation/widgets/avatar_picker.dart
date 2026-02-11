import 'dart:typed_data';

import 'package:motion_ai/core/constants/app_constants.dart';
import 'package:motion_ai/core/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

typedef AvatarSelected = void Function(Uint8List bytes, String ext);

class AvatarPicker extends StatelessWidget {
  final String? avatarUrl;
  final AvatarSelected onImageSelected;
  const AvatarPicker({super.key, required this.avatarUrl, required this.onImageSelected});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            final picker = ImagePicker();
            final file = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
            if (file == null) return;
            final bytes = await file.readAsBytes();
            final ext = file.path.split('.').last.toLowerCase();
            onImageSelected(bytes, ext.isEmpty ? 'png' : ext);
          },
          child: Stack(
            alignment: Alignment.bottomRight,
            children: [
              CircleAvatar(
                radius: 44,
                backgroundColor: const Color(0xffE7E0FF),
                child: ClipOval(
                  child: avatarUrl == null
                      ? SvgPicture.asset(
                          AppAssets.authPlaceholderSvg,
                          width: 72,
                          height: 72,
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          avatarUrl!,
                          width: 88,
                          height: 88,
                          fit: BoxFit.cover,
                          errorBuilder: (_, __, ___) => SvgPicture.asset(
                            AppAssets.authPlaceholderSvg,
                            width: 72,
                            height: 72,
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.edit, size: 16, color: Colors.white),
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
        const Text('Tap to change photo'),
      ],
    );
  }
}

