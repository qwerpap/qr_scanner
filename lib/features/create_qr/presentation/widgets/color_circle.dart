import 'package:flutter/material.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';

class ColorCircle extends StatelessWidget {
  const ColorCircle({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(width: 2, color: AppColors.borderColor),
      ),
    );
  }
}
