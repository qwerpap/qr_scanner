import 'package:flutter/material.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';
import 'package:qr_scanner/features/my_qr_codes/data/models/category_model.dart';

class CategoriesData {
  static List<CategoryModel> getCategories(BuildContext context) {
    return [
      CategoryModel(id: 'all', title: context.l10n.all),
      CategoryModel(id: 'url', title: context.l10n.urlCategory),
      CategoryModel(id: 'text', title: context.l10n.textCategory),
      CategoryModel(id: 'wifi', title: context.l10n.wifiCategory),
      CategoryModel(id: 'contact', title: context.l10n.contactCategory),
    ];
  }
}
