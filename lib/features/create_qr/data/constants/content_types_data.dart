import 'package:flutter/material.dart';
import 'package:qr_scanner/features/create_qr/data/models/content_type_model.dart';

class ContentTypesData {
  static final List<ContentTypeModel> types = [
    const ContentTypeModel(id: 'url', title: 'URL', iconData: Icons.link),
    const ContentTypeModel(
      id: 'text',
      title: 'Text',
      iconData: Icons.text_fields,
    ),
    const ContentTypeModel(
      id: 'contact',
      title: 'Contact',
      iconData: Icons.person,
    ),
  ];
}
