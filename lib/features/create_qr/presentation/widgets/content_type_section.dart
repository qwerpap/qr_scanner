import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';
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
        Text(context.l10n.contentType, style: AppFonts.titleLarge),
        const SizedBox(height: 15),
        Builder(
          builder: (context) {
            final types = ContentTypesData.getTypes(context);
            return Row(
              children: [
                Expanded(
                  child: ContentTypeCard(
                    type: types[0],
                    isActive: selectedTypeId == types[0].id,
                    onTap: () => onTypeSelected(types[0].id),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ContentTypeCard(
                    type: types[1],
                    isActive: selectedTypeId == types[1].id,
                    onTap: () => onTypeSelected(types[1].id),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ContentTypeCard(
                    type: types[2],
                    isActive: selectedTypeId == types[2].id,
                    onTap: () => onTypeSelected(types[2].id),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
