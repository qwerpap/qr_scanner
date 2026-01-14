import 'package:flutter/material.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';
import 'package:qr_scanner/features/create_qr/data/models/content_type_model.dart';

class ContentTypesData {
  static List<ContentTypeModel> getTypes(BuildContext context) {
    return [
      ContentTypeModel(id: 'url', title: context.l10n.urlCategory, iconData: Icons.link),
      ContentTypeModel(
        id: 'text',
        title: context.l10n.textCategory,
        iconData: Icons.text_fields,
      ),
      ContentTypeModel(
        id: 'contact',
        title: context.l10n.contactCategory,
        iconData: Icons.person,
      ),
    ];
  }
}
