import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/custom_elevated_button.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';

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
          title: isLoading ? context.l10n.processing : context.l10n.continueText,
        ),
        const SizedBox(height: 16),
        if (onRestore != null)
          TextButton(
            onPressed: isLoading ? null : onRestore,
            child: Text(
              context.l10n.restorePurchases,
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
          context.l10n.autoRenewableCancelAnytime,
          style: AppFonts.titleSmall.copyWith(
            fontWeight: FontWeight.w400,
            color: AppColors.greyTextColor,
          ),
        ),
        const SizedBox(height: 8),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 8,
          runSpacing: 4,
          children: [
            Text(context.l10n.termsOfService, style: linkTextStyle),
            Text(
              '•',
              style: AppFonts.titleSmall.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.greyTextColor,
              ),
            ),
            Text(context.l10n.privacyPolicy, style: linkTextStyle),
          ],
        ),
        const SizedBox(height: 32),
      ],
    );
  }
}
