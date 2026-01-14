import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/core/shared/widgets/custom_elevated_button.dart';

class SubscriptionInfo extends StatelessWidget {
  const SubscriptionInfo({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock subscription status - можно будет заменить на реальный статус
    // TODO: Replace with actual subscription status from state/Bloc
    final bool hasSubscription = false; // This is a mock value

    return BaseContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subscription',
                style: AppFonts.titleLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: hasSubscription
                      ? AppColors.greenColor.withOpacity(0.1) // ignore: dead_code
                      : AppColors.orangeColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  hasSubscription ? 'Active' : 'Free', // ignore: dead_code
                  style: AppFonts.titleSmall.copyWith(
                    color: hasSubscription
                        ? AppColors.greenColor // ignore: dead_code
                        : AppColors.orangeColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (!hasSubscription) ...[
            Text(
              'Upgrade to Premium to unlock all features',
              style: AppFonts.titleMedium.copyWith(
                color: AppColors.greyTextColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 16),
            CustomElevatedButton(
              onPressed: () {
                context.push('/paywall');
              },
              title: 'Upgrade to Premium',
            ),
          ] else ...[
            // ignore: dead_code
            // This code will be used when subscription is active
            Text(
              'Your subscription is active',
              style: AppFonts.titleMedium.copyWith(
                color: AppColors.greyTextColor,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Expires: Never',
              style: AppFonts.titleSmall.copyWith(
                color: AppColors.greyColor,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
