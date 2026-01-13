import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/custom_elevated_button.dart';

class WifiButton extends StatelessWidget {
  const WifiButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomElevatedButton(
      onPressed: () {
        // TODO: Implement Wi-Fi QR code creation
      },
      transparent: true,
      height: 49,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.wifi, color: AppColors.greyTextColor),
          const SizedBox(width: 15),
          Text(
            'Wi-Fi',
            style: AppFonts.titleMedium.copyWith(
              color: AppColors.greyTextColor,
            ),
          ),
        ],
      ),
    );
  }
}
