import 'package:flutter/material.dart';
import 'package:qr_scanner/features/paywall/data/constants/features_data.dart';
import 'package:qr_scanner/features/paywall/presentation/widgets/feature_card.dart';

class PaywallFeaturesList extends StatelessWidget {
  const PaywallFeaturesList({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < FeaturesData.features.length - 1 ? 16 : 0,
            ),
            child: FeatureCard(feature: FeaturesData.features[index]),
          );
        },
        childCount: FeaturesData.features.length,
      ),
    );
  }
}
