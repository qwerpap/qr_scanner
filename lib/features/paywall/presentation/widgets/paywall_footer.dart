import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/custom_elevated_button.dart';

class PaywallFooter extends StatelessWidget {
  const PaywallFooter({
    super.key,
    this.isLoading = false,
    this.onContinue,
    this.onRestore,
  });

  final bool isLoading;
  final VoidCallback? onContinue;
  final VoidCallback? onRestore;

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
        CustomElevatedButton(
          onPressed: isLoading ? null : onContinue,
          title: isLoading ? 'Processing...' : 'Continue',
        ),
        const SizedBox(height: 16),
        if (onRestore != null)
          TextButton(
            onPressed: isLoading ? null : onRestore,
            child: Text(
              'Restore Purchases',
              style: AppFonts.titleSmall.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.greyTextColor,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.greyTextColor,
              ),
            ),
          ),
        const SizedBox(height: 8),
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
