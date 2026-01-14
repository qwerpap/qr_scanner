import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';

class CustomNotification extends StatelessWidget {
  const CustomNotification({
    super.key,
    required this.message,
    this.isError = false,
    this.icon,
    this.onDismiss,
    this.duration = const Duration(seconds: 3),
  });

  final String message;
  final bool isError;
  final IconData? icon;
  final VoidCallback? onDismiss;
  final Duration duration;

  static void show({
    required BuildContext context,
    required String message,
    bool isError = false,
    Duration duration = const Duration(seconds: 3),
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: CustomNotification(
          message: message,
          isError: isError,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).padding.bottom + 80,
          left: 24,
          right: 24,
        ),
        duration: duration,
        padding: EdgeInsets.zero,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final displayIcon = icon ?? (isError ? Icons.error_outline : Icons.check_circle_outline);
    final iconColor = isError ? AppColors.orangeColor : AppColors.greenColor;
    final iconBgColor = isError 
        ? AppColors.orangeColor.withOpacity(0.1) 
        : AppColors.greenColor.withOpacity(0.1);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
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
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBgColor,
            ),
            child: Icon(
              displayIcon,
              size: 16,
              color: iconColor,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: AppFonts.titleMedium.copyWith(
                color: AppColors.blackColor,
                fontSize: 15,
              ),
            ),
          ),
          if (onDismiss != null) ...[
            const SizedBox(width: 8),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: onDismiss,
                borderRadius: BorderRadius.circular(12),
                child: Icon(
                  Icons.close,
                  size: 18,
                  color: AppColors.greyTextColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
