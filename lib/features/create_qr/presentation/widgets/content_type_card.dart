import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/custom_elevated_button.dart';
import 'package:qr_scanner/features/create_qr/data/models/content_type_model.dart';

class ContentTypeCard extends StatelessWidget {
  const ContentTypeCard({
    super.key,
    required this.type,
    required this.isActive,
    required this.onTap,
  });

  final ContentTypeModel type;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: onTap,
      transparent: true,
      isActive: isActive,
      height: 71,
      child: type.id == 'url'
          ? Row(
              children: [
                Icon(
                  type.iconData,
                  color: isActive
                      ? AppColors.blackColor
                      : AppColors.greyTextColor,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  type.title,
                  style: AppFonts.titleMedium.copyWith(
                    fontSize: 15,
                    color: isActive
                        ? AppColors.blackColor
                        : AppColors.greyTextColor,
                    fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                  ),
                ),
              ],
            )
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  type.iconData,
                  color: isActive
                      ? AppColors.blackColor
                      : AppColors.greyTextColor,
                  size: 24,
                ),
                const SizedBox(height: 3),
                Text(
                  type.title,
                  style: AppFonts.titleMedium.copyWith(
                    fontSize: 15,
                    color: isActive
                        ? AppColors.blackColor
                        : AppColors.greyTextColor,
                  ),
                ),
              ],
            ),
    );
  }
}
