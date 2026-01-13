import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/custom_elevated_button.dart';

class PaywallFooter extends StatelessWidget {
  const PaywallFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final linkTextStyle = AppFonts.titleSmall.copyWith(
      fontWeight: FontWeight.w400,
      color: AppColors.greyTextColor,
      decoration: TextDecoration.underline,
      decorationColor: AppColors.greyTextColor,
    );

    return Column(
      children: [
        const SizedBox(height: 32),
        CustomElevatedButton(onPressed: () {}, title: 'Continue'),
        const SizedBox(height: 16),
        Text(
          'Auto-renewable. Cancel anytime.',
          style: AppFonts.titleSmall.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.greyTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Terms of Service', style: linkTextStyle),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                '•',
                style: AppFonts.titleSmall.copyWith(
                  fontWeight: FontWeight.w400,
                  color: AppColors.greyTextColor,
                ),
              ),
            ),
            Text('Privacy Policy', style: linkTextStyle),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
