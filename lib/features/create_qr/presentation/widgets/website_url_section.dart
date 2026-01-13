import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/custom_text_field.dart';

class WebsiteUrlSection extends StatelessWidget {
  const WebsiteUrlSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Website URL', style: AppFonts.titleMedium),
        const SizedBox(height: 11),
        const CustomTextField(hintText: 'https://example.com'),
      ],
    );
  }
}
