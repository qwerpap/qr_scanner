import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    this.icon,
    this.iconPath,
    required this.label,
    required this.onTap,
  }) : assert(
         icon != null || iconPath != null,
         'Either icon or iconPath must be provided',
       );

  final IconData? icon;
  final String? iconPath;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: BaseContainer(
          borderRadius: 12,
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              iconPath != null
                  ? SvgPicture.asset(
                      iconPath!,
                      colorFilter: const ColorFilter.mode(
                        AppColors.greyTextColor,
                        BlendMode.srcIn,
                      ),
                      width: 24,
                      height: 24,
                    )
                  : Icon(icon!, color: AppColors.greyTextColor, size: 24),
              const SizedBox(height: 8),
              Text(
                label,
                style: AppFonts.titleMedium.copyWith(
                  color: AppColors.greyTextColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
