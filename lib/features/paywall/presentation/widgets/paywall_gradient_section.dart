import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/features/paywall/presentation/widgets/paywall_header.dart';

class PaywallGradientSection extends StatelessWidget {
  const PaywallGradientSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                AppColors.scaffoldBgColor,
                const Color.fromRGBO(232, 244, 255, 1),
                const Color.fromRGBO(247, 251, 255, 1),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),
        // Decorative circles
        Positioned(
          top: -50,
          right: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor.withOpacity(0.1),
            ),
          ),
        ),
        Positioned(
          top: 100,
          left: -80,
          child: Container(
            width: 160,
            height: 160,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor.withOpacity(0.08),
            ),
          ),
        ),
        Positioned(
          top: 300,
          right: -60,
          child: Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor.withOpacity(0.1),
            ),
          ),
        ),
        Positioned(
          top: 400,
          left: 50,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.primaryColor.withOpacity(0.08),
            ),
          ),
        ),
        // Content on gradient background
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            children: [
              const PaywallHeader(),
              const SizedBox(height: 16),
              Image.asset(ImageSource.paywallQr, height: 217),
              const SizedBox(height: 16),
              Text(
                'Unlock Full QR\nTools',
                textAlign: TextAlign.center,
                style: AppFonts.titleLarge.copyWith(
                  fontSize: 34,
                  height: 1.2,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 13),
              Text(
                'Unlimited scans, custom QR creation, and full history access.',
                textAlign: TextAlign.center,
                style: AppFonts.titleMedium.copyWith(
                  color: AppColors.greyTextColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
