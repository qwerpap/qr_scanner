import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/features/paywall/data/models/feature_model.dart';

class FeatureCard extends StatelessWidget {
  const FeatureCard({
    super.key,
    required this.feature,
  });

  final FeatureModel feature;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Image.asset(
            feature.iconPath,
            width: 43,
            height: 48,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feature.title,
                  style: AppFonts.titleLarge,
                ),
                const SizedBox(height: 4),
                Text(
                  feature.description,
                  style: AppFonts.titleMedium.copyWith(
                    color: AppColors.greyTextColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
