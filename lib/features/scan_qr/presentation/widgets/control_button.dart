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
                color: AppColors.scaffoldBgColor,
              ),
              child: Icon(
                model.icon,
                color: AppColors.greyTextColor,
                size: 21,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              model.label,
              style: AppFonts.titleSmall.copyWith(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
