import 'package:flutter/material.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Divider(height: 0, color: AppColors.scaffoldBgColor),
    );
  }
}
