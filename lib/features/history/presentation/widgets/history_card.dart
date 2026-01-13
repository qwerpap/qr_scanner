import 'package:flutter/material.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/core/shared/widgets/container_with_icon.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';
import 'package:qr_scanner/core/theme/app_fonts.dart';
import 'package:qr_scanner/features/history/data/models/history_item_model.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    super.key,
    required this.item,
  });

  final HistoryItemModel item;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          ContainerWithIcon(
            iconPath: item.iconPath,
            color: Color(item.iconColor),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: AppFonts.titleLarge),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.content,
                        style: AppFonts.titleMedium.copyWith(
                          color: AppColors.greyTextColor,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.scaffoldBgColor,
                      ),
                      child: const Icon(
                        Icons.copy,
                        color: AppColors.greyTextColor,
                        size: 16,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.scaffoldBgColor,
                      ),
                      child: const Icon(
                        Icons.share,
                        color: AppColors.greyTextColor,
                        size: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Row(
                  children: [
                    Text(
                      item.status,
                      style: AppFonts.titleSmall.copyWith(
                        color: AppColors.greyColor,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      ' • ',
                      style: AppFonts.titleSmall.copyWith(
                        color: AppColors.greyColor,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      item.timestamp,
                      style: AppFonts.titleSmall.copyWith(
                        color: AppColors.greyColor,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
