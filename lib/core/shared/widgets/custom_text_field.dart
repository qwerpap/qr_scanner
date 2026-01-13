import 'package:flutter/material.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';
import 'package:qr_scanner/core/theme/app_fonts.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.hintText});

  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: AppFonts.titleMedium.copyWith(
                  color: AppColors.greyColor,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.all(16),
              ),
              style: AppFonts.titleMedium.copyWith(color: AppColors.blackColor),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Transform.rotate(
              angle: -0.785398,
              child: Icon(Icons.link, color: AppColors.greyColor, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}
