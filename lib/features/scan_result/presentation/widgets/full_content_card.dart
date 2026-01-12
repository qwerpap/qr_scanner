import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';

class FullContentCard extends StatelessWidget {
  const FullContentCard({
    super.key,
    required this.content,
  });

  final String content;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.scaffoldBgColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Full Content', style: AppFonts.titleMedium),
          const SizedBox(height: 8),
          Text(
            content,
            style: AppFonts.titleLarge.copyWith(
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}
