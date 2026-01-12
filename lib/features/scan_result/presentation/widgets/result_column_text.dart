import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';

class ResultColumnText extends StatelessWidget {
  const ResultColumnText({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFonts.titleSmall.copyWith(
            fontSize: 13,
            color: AppColors.greyTextColor,
          ),
        ),
        Text(
          subtitle,
          style: AppFonts.titleMedium.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
