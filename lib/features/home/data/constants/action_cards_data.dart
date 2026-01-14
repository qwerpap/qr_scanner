import 'package:flutter/material.dart';

import '../../../../core/constants/image_source.dart';
import '../../../../core/l10n/app_localizations_helper.dart';
import '../../../../core/theme/app_colors.dart';
import '../models/action_card_model.dart';

class ActionCardsData {
  ActionCardsData._();

  static List<ActionCardModel> getCards(BuildContext context) {
    return [
      ActionCardModel(
        title: context.l10n.scanQr,
        subtitle: context.l10n.quickScan,
        iconPath: ImageSource.scanQr,
        color: AppColors.primaryColor,
      ),
      ActionCardModel(
        title: context.l10n.createQr,
        subtitle: context.l10n.generateNew,
        iconData: Icons.add,
        color: AppColors.greenColor,
      ),
      ActionCardModel(
        title: context.l10n.myQrCodesTitle,
        subtitle: context.l10n.savedCodes,
        iconPath: ImageSource.myQrCodes,
        color: AppColors.orangeColor,
      ),
      ActionCardModel(
        title: context.l10n.historyTitle,
        subtitle: context.l10n.recentScans,
        iconPath: ImageSource.history,
        color: AppColors.greyColor,
      ),
    ];
  }
}
