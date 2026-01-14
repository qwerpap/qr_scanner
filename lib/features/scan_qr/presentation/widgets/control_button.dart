import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/features/scan_qr/data/models/control_button_model.dart';

class ControlButton extends StatelessWidget {
  const ControlButton({
    super.key,
    required this.model,
  });

  final ControlButtonModel model;

  @override
  Widget build(BuildContext context) {
    final containerColor = model.isActive
        ? AppColors.primaryColor
        : AppColors.scaffoldBgColor;
    final iconColor = model.isActive
        ? AppColors.whiteColor
        : AppColors.greyTextColor;
    final textColor = AppColors.greyTextColor;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: model.onTap,
        borderRadius: BorderRadius.circular(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 48,
              width: 48,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: containerColor,
              ),
              child: Icon(
                model.icon,
                color: iconColor,
                size: 21,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              model.label,
              style: AppFonts.titleSmall.copyWith(
                fontSize: 14,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
