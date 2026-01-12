import 'package:flutter/material.dart';
import 'package:qr_scanner/core/constants/image_source.dart';
import 'package:qr_scanner/features/my_qr_codes/presentation/widgets/grid_category_card.dart';

class QrCodesGrid extends StatelessWidget {
  const QrCodesGrid({
    super.key,
    this.itemCount = 4,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.7,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return GridCategoryCard(iconPath: ImageSource.scannedQr);
          },
          childCount: itemCount,
        ),
      ),
    );
  }
}
