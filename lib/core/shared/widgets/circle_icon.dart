import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';

class CirleIconn extends StatelessWidget {
  const CirleIconn({
    super.key,
    required this.iconPath,
    required this.iconData,
    required this.color,
    this.iconColor,
    this.iconSize = 14,
    this.size = 40,
  });

  final String? iconPath;
  final IconData? iconData;
  final Color color;
  final Color? iconColor;
  final double iconSize;
  final double size;

  @override
  Widget build(BuildContext context) {
    final effectiveIconColor = iconColor ?? AppColors.whiteColor;
    return Container(
      height: size,
      width: size,
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: iconPath != null
            ? SvgPicture.asset(
                iconPath!,
                colorFilter: ColorFilter.mode(
                  effectiveIconColor,
                  BlendMode.srcIn,
                ),
                width: iconSize,
                height: iconSize,
              )
            : Icon(iconData!, color: effectiveIconColor, size: iconSize),
      ),
    );
  }
}
