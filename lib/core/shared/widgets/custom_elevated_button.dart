import 'package:flutter/material.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';
import 'package:qr_scanner/core/theme/app_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    this.title,
    this.child,
  }) : assert(
         title != null || child != null,
         'Either title or child must be provided',
       );

  final VoidCallback? onPressed;
  final String? title;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(child: content),
            ),
          ),
        ),
      ),
    );
  }
}
