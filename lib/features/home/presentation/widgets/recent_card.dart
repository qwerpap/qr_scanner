import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';

class RecentCard extends StatelessWidget {
  const RecentCard({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Row(
        children: [
          RecentIcon(),
          SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Scanned website link', style: AppFonts.titleLarge),
              Text(
                '2 minutes ago',
                style: AppFonts.titleMedium.copyWith(
                  color: AppColors.greyTextColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class RecentIcon extends StatelessWidget {
  const RecentIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: AppColors.primaryColor,
      ),
      child: Center(
        child: SvgPicture.asset(
          ImageSource.scanQr,
          color: AppColors.whiteColor,
          height: 14,
        ),
      ),
    );
  }
}
