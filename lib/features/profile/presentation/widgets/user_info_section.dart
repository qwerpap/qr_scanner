import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';

class UserInfoSection extends StatelessWidget {
  const UserInfoSection({
    super.key,
    this.userName,
    this.onNameTap,
    this.hasSubscription = false,
  });

  final String? userName;
  final VoidCallback? onNameTap;
  final bool hasSubscription;

  String get _displayName {
    return userName ?? 'Name';
  }

  String get _initial {
    if (userName != null && userName!.isNotEmpty) {
      return userName!.substring(0, 1).toUpperCase();
    }
    return 'N';
  }

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 64,
            height: 64,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: AppColors.primaryGradient,
            ),
            child: Center(
              child: Text(
                _initial,
                style: AppFonts.displayMedium.copyWith(
                  color: AppColors.whiteColor,
                  fontSize: 24,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: onNameTap,
                  child: Row(
                    children: [
                      Text(
                        _displayName,
                        style: AppFonts.titleLarge.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.edit,
                        size: 16,
                        color: AppColors.greyTextColor,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: hasSubscription
                            ? AppColors.greenColor.withOpacity(0.1)
                            : AppColors.orangeColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        hasSubscription ? 'Premium' : 'Free',
                        style: AppFonts.titleSmall.copyWith(
                          color: hasSubscription
                              ? AppColors.greenColor
                              : AppColors.orangeColor,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
