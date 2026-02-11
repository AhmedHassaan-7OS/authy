import 'package:flutter/material.dart';

class AuthScaffold extends StatelessWidget {
  final Widget child;
  final Widget? floatingBottomBar;
  final bool centerContent;

  const AuthScaffold({
    super.key,
    required this.child,
    this.floatingBottomBar,
    this.centerContent = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      bottomNavigationBar: const SizedBox.shrink(),
      body: Stack(
        children: [
          const _AuthBackground(),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: centerContent
                  ? Center(child: SingleChildScrollView(child: child))
                  : SingleChildScrollView(child: child),
            ),
          ),
          if (floatingBottomBar != null) Align(
            alignment: Alignment.bottomCenter,
            child: floatingBottomBar!,
          ),
        ],
      ),
    );
  }
}

class _AuthBackground extends StatelessWidget {
  const _AuthBackground();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xff100B20), Color(0xff24184A)],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -140,
            right: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xffCBB7FF).withOpacity(0.16),
              ),
            ),
          ),
          Positioned(
            bottom: -160,
            left: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff7C66C5).withOpacity(0.2),
              ),
            ),
          ),
          Positioned(
            top: 120,
            left: -60,
            child: Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xff2E1F5A).withOpacity(0.35),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
