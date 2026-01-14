import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';

class ContainerWithIcon extends StatelessWidget {
  const ContainerWithIcon({
    super.key,
    this.iconPath,
    this.iconData,
    required this.color,
  }) : assert(
          iconPath != null || iconData != null,
          'Either iconPath or iconData must be provided',
        );

  final String? iconPath;
  final IconData? iconData;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: 64,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: Center(
        child: iconPath != null
            ? SvgPicture.asset(
                iconPath!,
                height: 24,
                width: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.whiteColor,
                  BlendMode.srcIn,
                ),
              )
            : Icon(
                iconData!,
                size: 24,
                color: AppColors.whiteColor,
              ),
      ),
    );
  }
}
