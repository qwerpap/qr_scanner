import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/features/create_qr/data/constants/content_types_data.dart';
import 'package:qr_scanner/features/create_qr/presentation/widgets/content_type_card.dart';

class ContentTypeSection extends StatelessWidget {
  const ContentTypeSection({
    super.key,
    required this.selectedTypeId,
    required this.onTypeSelected,
  });

  final String selectedTypeId;
  final ValueChanged<String> onTypeSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Content Type', style: AppFonts.titleLarge),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: ContentTypeCard(
                type: ContentTypesData.types[0],
                isActive: selectedTypeId == ContentTypesData.types[0].id,
                onTap: () => onTypeSelected(ContentTypesData.types[0].id),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ContentTypeCard(
                type: ContentTypesData.types[1],
                isActive: selectedTypeId == ContentTypesData.types[1].id,
                onTap: () => onTypeSelected(ContentTypesData.types[1].id),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: ContentTypeCard(
                type: ContentTypesData.types[2],
                isActive: selectedTypeId == ContentTypesData.types[2].id,
                onTap: () => onTypeSelected(ContentTypesData.types[2].id),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
