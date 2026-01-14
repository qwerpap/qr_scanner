import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/features/splash/presentation/widgets/loading_dots.dart';

class SplashContent extends StatefulWidget {
  const SplashContent({super.key});

  @override
  State<SplashContent> createState() => _SplashContentState();
}

class _SplashContentState extends State<SplashContent>
    with TickerProviderStateMixin {
  late final AnimationController _logoController;
  late final AnimationController _titleController;
  late final AnimationController _sloganController;
  late final AnimationController _loaderController;

  late final Animation<double> _logoFadeAnimation;
  late final Animation<double> _logoScaleAnimation;
  late final Animation<Offset> _titleSlideAnimation;
  late final Animation<double> _titleFadeAnimation;
  late final Animation<Offset> _sloganSlideAnimation;
  late final Animation<double> _sloganFadeAnimation;
  late final Animation<double> _loaderFadeAnimation;

  @override
  void initState() {
    super.initState();

    // Logo animation (Fade + Scale)
    _logoController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _logoFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );
    _logoScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _logoController,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    // Title animation (Fade + Slide from bottom)
    _titleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _titleSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _titleController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    );
    _titleFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _titleController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    );

    // Slogan animation (Fade + Slide from bottom)
    _sloganController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _sloganSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _sloganController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    );
    _sloganFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _sloganController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    );

    // Loader animation (Fade)
    _loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    _loaderFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _loaderController,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    );

    // Start animations in sequence
    _startAnimations();
  }

  void _startAnimations() {
    if (mounted) {
    _logoController.forward();
    }
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) _titleController.forward();
    });
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _sloganController.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) _loaderController.forward();
    });
  }

  @override
  void dispose() {
    _logoController.dispose();
    _titleController.dispose();
    _sloganController.dispose();
    _loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo with Fade + Scale
            FadeTransition(
              opacity: _logoFadeAnimation,
              child: ScaleTransition(
                scale: _logoScaleAnimation,
                child: Image.asset(
                  ImageSource.splashQr,
                  height: 160,
                  width: 160,
                ),
              ),
            ),
            const SizedBox(height: 32),
            // Title with Fade + Slide
            FadeTransition(
              opacity: _titleFadeAnimation,
              child: SlideTransition(
                position: _titleSlideAnimation,
                child: Text(
                  'QR Master',
                  style: AppFonts.titleLarge.copyWith(
                    fontSize: 34,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 8),
            // Slogan with Fade + Slide
            FadeTransition(
              opacity: _sloganFadeAnimation,
              child: SlideTransition(
                position: _sloganSlideAnimation,
                child: Text(
                  'Scan • Create • Manage',
                  style: AppFonts.titleLarge.copyWith(
                    color: AppColors.greyTextColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50),
            // Loader with Fade
            FadeTransition(
              opacity: _loaderFadeAnimation,
              child: Column(
                children: [
                  const LoadingDots(),
                  const SizedBox(height: 16),
                  Text(
                    'Loading...',
                    style: AppFonts.titleMedium.copyWith(
                      color: AppColors.greyTextColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
