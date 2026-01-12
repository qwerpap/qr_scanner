import 'package:flutter/material.dart';
import 'package:qr_scanner/core/constants/image_source.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/circle_icon.dart';

class QrCodeInfoCard extends StatelessWidget {
  const QrCodeInfoCard({
    super.key,
    required this.title,
    required this.url,
  });

  final String title;
  final String url;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CirleIconn(
          size: 48,
          iconPath: ImageSource.link,
          iconData: null,
          iconSize: 20,
          color: AppColors.primaryColor,
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppFonts.titleMedium),
              const SizedBox(height: 2),
              Text(
                url,
                style: AppFonts.titleLarge.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.visible,
                softWrap: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
