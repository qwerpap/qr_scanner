import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/features/paywall/data/models/plan_model.dart';

class PlanCard extends StatelessWidget {
  const PlanCard({
    super.key,
    required this.plan,
    required this.isSelected,
    required this.onTap,
  });

  final PlanModel plan;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected
                    ? const Color.fromRGBO(122, 203, 255, 1)
                    : AppColors.borderColor,
                width: 1,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: const Color.fromRGBO(0, 0, 0, 0.06),
                        offset: const Offset(0, 4),
                        blurRadius: 16,
                        spreadRadius: 0,
                      ),
                      BoxShadow(
                        color: const Color.fromRGBO(122, 203, 255, 0.45),
                        offset: const Offset(0, 0),
                        blurRadius: 34.88,
                        spreadRadius: 0,
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: const Color.fromRGBO(0, 0, 0, 0.06),
                        offset: const Offset(0, 4),
                        blurRadius: 16,
                        spreadRadius: 0,
                      ),
                    ],
            ),
            child: Column(
              children: [
                Text(
                  plan.name,
                  style: AppFonts.titleMedium.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      plan.price,
                      style: AppFonts.titleMedium.copyWith(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text(
                        plan.period,
                        style: AppFonts.titleMedium.copyWith(
                          color: AppColors.greyTextColor,
                        ),
                      ),
                    ),
                  ],
                ),
                if (plan.originalPrice != null) ...[
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        plan.originalPrice!,
                        style: AppFonts.titleMedium.copyWith(
                          color: AppColors.greyColor,
                          decoration: TextDecoration.lineThrough,
                          decorationColor: AppColors.greyColor,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        plan.savingsText ?? '',
                        style: AppFonts.titleMedium.copyWith(
                          color: AppColors.greenColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ],
                const SizedBox(height: 16),
                Text(
                  plan.description,
                  style: AppFonts.titleMedium.copyWith(
                    color: AppColors.greyTextColor,
                  ),
                ),
              ],
            ),
          ),
          if (plan.badgeText != null && plan.badgePosition != null)
            Positioned(
              top: -8,
              left: plan.badgePosition == BadgePosition.topLeft ? 0 : null,
              right: plan.badgePosition == BadgePosition.topRight
                  ? 16
                  : plan.badgePosition == BadgePosition.topLeft
                  ? 0
                  : null,
              child: plan.badgePosition == BadgePosition.topLeft
                  ? Center(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor,
                          borderRadius: BorderRadius.circular(99),
                        ),
                        child: Text(
                          plan.badgeText!,
                          style: AppFonts.titleSmall.copyWith(
                            color: AppColors.whiteColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    )
                  : Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.greenColor,
                        borderRadius: BorderRadius.circular(99),
                      ),
                      child: Text(
                        plan.badgeText!,
                        style: AppFonts.titleSmall.copyWith(
                          color: AppColors.whiteColor,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
            ),
        ],
      ),
    );
  }
}
