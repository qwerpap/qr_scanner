import 'package:flutter/material.dart';

import '../../../../core/constants/image_source.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/models/recent_activity_model.dart';

class RecentActivityData {
  RecentActivityData._();

  static const List<RecentActivityModel> activities = [
    RecentActivityModel(
      title: 'Scanned website link',
      timestamp: '2 minutes ago',
      iconPath: ImageSource.scannedQr,
      color: AppColors.primaryColor,
    ),
    RecentActivityModel(
      title: 'Created WiFi QR',
      timestamp: '1 hour ago',
      iconData: Icons.add,
      color: AppColors.greenColor,
    ),
    RecentActivityModel(
      title: 'Shared contact QR',
      timestamp: '3 hours ago',
      iconData: Icons.share,
      color: AppColors.orangeColor,
    ),
  ];
}
