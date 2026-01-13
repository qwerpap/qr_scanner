import 'package:flutter/material.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';
import 'package:qr_scanner/core/theme/app_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    this.title,
    this.child,
    this.transparent = false,
    this.isActive = false,
    this.height,
  }) : assert(
         title != null || child != null,
         'Either title or child must be provided',
       );

  final VoidCallback? onPressed;
  final String? title;
  final Widget? child;
  final bool transparent;
  final bool isActive;
  final double? height;

  @override
  Widget build(BuildContext context) {
    if (transparent) {
      final content =
          child ??
          Text(
            title!,
            style: AppFonts.titleMedium.copyWith(
              fontSize: 15,
              color: isActive
                  ? AppColors.blackColor
                  : AppColors.greyTextColor,
              fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            ),
          );

      return Material(
        color: Colors.transparent,
        child: Ink(
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderColor),
            borderRadius: BorderRadius.circular(12),
            color: isActive
                ? AppColors.whiteColor
                : AppColors.scaffoldBgColor,
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ]
                : null,
          ),
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              height: height ?? 71,
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: child != null ? child : Center(child: content),
            ),
          ),
        ),
      );
    }

    final content =
        child ??
        Text(
          title!,
          style: AppFonts.titleLarge.copyWith(
            color: AppColors.whiteColor,
            fontWeight: FontWeight.w600,
          ),
        );

    return Material(
      color: Colors.transparent,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: AppColors.primaryGradient,
          border: Border.all(width: 1, color: AppColors.borderColor),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.06),
              offset: const Offset(0, 4),
              blurRadius: 16,
              spreadRadius: 0,
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.circular(18),
            child: Container(
              height: height,
              padding: height != null
                  ? EdgeInsets.zero
                  : const EdgeInsets.symmetric(vertical: 16),
              child: Center(child: content),
            ),
          ),
        ),
      ),
    );
  }
}
