import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/core/shared/widgets/circle_icon.dart';
import 'package:qr_scanner/features/home/data/models/recent_activity_model.dart';

class RecentCard extends StatelessWidget {
  const RecentCard({super.key, required this.model, this.onPressed});

  final RecentActivityModel model;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(16),
        child: BaseContainer(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            children: [
              CirleIconn(
                iconPath: model.iconPath,
                iconData: model.iconData,
                color: model.color,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.title, style: AppFonts.titleLarge),
                    Text(
                      model.timestamp,
                      style: AppFonts.titleMedium.copyWith(
                        color: AppColors.greyTextColor,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.greyColor),
            ],
          ),
        ),
      ),
    );
  }
}
