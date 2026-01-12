import 'package:flutter/material.dart';

import '../../../../core/constants/image_source.dart';
import '../../../../core/theme/app_colors.dart';
import '../models/action_card_model.dart';

class ActionCardsData {
  ActionCardsData._();

  static const List<ActionCardModel> cards = [
    ActionCardModel(
      title: 'Scan QR',
      subtitle: 'Quick scan',
      iconPath: ImageSource.scanQr,
      color: AppColors.primaryColor,
    ),
    ActionCardModel(
      title: 'Create QR',
      subtitle: 'Generate new',
      iconData: Icons.add,
      color: AppColors.greenColor,
    ),
    ActionCardModel(
      title: 'My QR Codes',
      subtitle: 'Saved codes',
      iconPath: ImageSource.myQrCodes,
      color: AppColors.orangeColor,
    ),
    ActionCardModel(
      title: 'History',
      subtitle: 'Recent scans',
      iconPath: ImageSource.history,
      color: AppColors.greyColor,
    ),
  ];
}
