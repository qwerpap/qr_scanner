import 'package:flutter/material.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';
import 'package:qr_scanner/features/my_qr_codes/data/models/category_model.dart';

class HistoryCategoriesData {
  static List<CategoryModel> getCategories(BuildContext context) {
    return [
      CategoryModel(id: 'all', title: context.l10n.all),
      CategoryModel(id: 'scanned', title: context.l10n.scannedCategory),
      CategoryModel(id: 'created', title: context.l10n.createdCategory),
    ];
  }
}
