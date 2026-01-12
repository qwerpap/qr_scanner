import 'package:flutter/material.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/core/shared/widgets/container_with_icon.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';
import 'package:qr_scanner/core/theme/app_fonts.dart';
import 'package:qr_scanner/features/home/data/models/action_card_model.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({super.key, required this.model});

  final ActionCardModel model;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ContainerWithIcon(
              iconPath: model.iconPath,
              iconData: model.iconData,
              color: model.color,
            ),
            const SizedBox(height: 16),
            Text(
              model.title,
              style: AppFonts.titleLarge.copyWith(fontSize: 17),
            ),
            const SizedBox(height: 6),
            Text(
              model.subtitle,
              style: AppFonts.titleMedium.copyWith(
                color: AppColors.greyTextColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
