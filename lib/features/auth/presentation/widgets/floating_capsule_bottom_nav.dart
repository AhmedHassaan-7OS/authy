import 'package:flutter/material.dart';

class FloatingCapsuleBottomNav extends StatelessWidget {
  final int selectedIndex;
  final VoidCallback onHomeTap;
  final VoidCallback onFaceTap;

  const FloatingCapsuleBottomNav({
    super.key,
    required this.selectedIndex,
    required this.onHomeTap,
    required this.onFaceTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(18, 0, 18, 16),
      child: SizedBox(
        height: 64,
        child: Container(
          decoration: BoxDecoration(
            color: const Color(0xC0323439),
            borderRadius: BorderRadius.circular(40),
            border: Border.all(color: const Color(0x66FFFFFF)),
          ),
          child: Row(
            children: [
              Expanded(
                child: _NavIcon(
                  icon: Icons.home_rounded,
                  isActive: selectedIndex == 0,
                  onTap: onHomeTap,
                ),
              ),
              Expanded(
                child: _NavIcon(
                  icon: Icons.face_retouching_natural_rounded,
                  isActive: selectedIndex == 1,
                  onTap: onFaceTap,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback onTap;

  const _NavIcon({
    required this.icon,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onTap,
      iconSize: 30,
      color: isActive ? const Color(0xffE6E9EF) : const Color(0xff9196A0),
      icon: Icon(icon),
    );
  }
}
