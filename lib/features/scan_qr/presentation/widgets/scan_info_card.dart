import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/core/shared/widgets/circle_icon.dart';

class ScanInfoCard extends StatelessWidget {
  const ScanInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
      child: Row(
        children: [
          const CirleIconn(
            iconPath: null,
            iconData: Icons.info_outline,
            color: AppColors.primaryColor,
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Align QR code within frame',
                style: AppFonts.titleLarge.copyWith(
                  color: AppColors.greyTextColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                'Keep your device steady',
                style: AppFonts.titleLarge.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w300,
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
