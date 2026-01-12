import 'package:flutter/material.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';
import 'package:qr_scanner/core/theme/app_fonts.dart';

class WelcomeText extends StatelessWidget {
  const WelcomeText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Welcome, Name!',
          style: AppFonts.displayLarge.copyWith(fontSize: 28),
        ),
        const SizedBox(height: 4),
        Text(
          'Manage your QR codes easily',
          style: AppFonts.titleLarge.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.greyTextColor,
          ),
        ),
      ],
    );
  }
}
