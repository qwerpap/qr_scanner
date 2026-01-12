import 'package:flutter/material.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';

class BaseContainer extends StatelessWidget {
  const BaseContainer({super.key, required this.child, this.padding});

  final Widget child;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1,
          color: const Color.fromRGBO(229, 231, 235, 1),
        ),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.06),
            offset: const Offset(0, 4),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      child: child,
    );
  }
}
