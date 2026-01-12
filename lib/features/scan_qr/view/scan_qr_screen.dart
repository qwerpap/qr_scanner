import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/core/shared/widgets/circle_icon.dart';
import 'package:qr_scanner/core/shared/widgets/custom_app_bar.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';

class ScanQrScreen extends StatelessWidget {
  const ScanQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'Scan QR Code'),
      body: ListView(
        padding: EdgeInsets.all(24),
        children: [
          SizedBox(height: 20),
          BaseContainer(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
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
          ),

          SizedBox(height: 20),
          BaseContainer(
            padding: EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CirleIconn(
                  iconPath: ImageSource.flash,
                  iconData: null,
                  color: AppColors.scaffoldBgColor,
                  iconColor: AppColors.greyColor,
                  iconSize: 20,
                  size: 48,
                ),
                SizedBox(width: 32),
                CirleIconn(
                  iconPath: ImageSource.flash,
                  iconData: null,
                  color: AppColors.scaffoldBgColor,
                  iconColor: AppColors.greyColor,
                  iconSize: 20,
                  size: 48,
                ),
                SizedBox(width: 32),
                CirleIconn(
                  iconPath: ImageSource.flash,
                  iconData: null,
                  color: AppColors.scaffoldBgColor,
                  iconColor: AppColors.greyColor,
                  iconSize: 20,
                  size: 48,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
