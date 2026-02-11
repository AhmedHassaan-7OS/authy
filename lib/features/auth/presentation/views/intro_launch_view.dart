import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motion_ai/core/utils/service_locator.dart';
import 'package:motion_ai/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:motion_ai/features/auth/presentation/views/auth_root_view.dart';
import 'package:motion_ai/features/auth/presentation/widgets/auth_scaffold.dart';

class IntroLaunchView extends StatefulWidget {
  const IntroLaunchView({super.key});

  @override
  State<IntroLaunchView> createState() => _IntroLaunchViewState();
}

class _IntroLaunchViewState extends State<IntroLaunchView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late final Animation<Offset> _slidingAnimation;
  bool _showAuthRoot = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _slidingAnimation = Tween<Offset>(
      begin: const Offset(0, 1.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutCubic,
      ),
    );

    _animationController.forward();
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;
      setState(() => _showAuthRoot = true);
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_showAuthRoot) {
      return BlocProvider(
        create: (_) => getIt<AuthCubit>()..loadCurrentUser(),
        child: const AuthRootView(),
      );
    }

    return AuthScaffold(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'motion ai',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  letterSpacing: 1.1,
                  height: 1.1,
                ),
          ),
          const SizedBox(height: 14),
          SlidingText(slidingAnimation: _slidingAnimation),
        ],
      ),
    );
  }
}

class SlidingText extends StatelessWidget {
  const SlidingText({
    super.key,
    required this.slidingAnimation,
  });

  final Animation<Offset> slidingAnimation;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: slidingAnimation,
      child: Text(
        'power by google lm kit',
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w400,
              color: const Color(0xffD7D0F2),
              letterSpacing: 0.2,
            ),
      ),
    );
  }
}
