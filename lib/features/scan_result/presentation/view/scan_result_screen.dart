import 'package:flutter/material.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/core/shared/widgets/custom_app_bar.dart';
import 'package:qr_scanner/core/shared/widgets/custom_divider.dart';
import 'package:qr_scanner/features/scan_result/presentation/widgets/action_buttons_row.dart';
import 'package:qr_scanner/features/scan_result/presentation/widgets/full_content_card.dart';
import 'package:qr_scanner/features/scan_result/presentation/widgets/open_link_button.dart';
import 'package:qr_scanner/features/scan_result/presentation/widgets/qr_code_info_card.dart';
import 'package:qr_scanner/features/scan_result/presentation/widgets/qr_code_metadata.dart';
import 'package:qr_scanner/features/scan_result/presentation/widgets/scan_success_header.dart';

class ScanResultScreen extends StatelessWidget {
  const ScanResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'Scan Result', showCloseButton: true),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
        children: [
          const ScanSuccessHeader(),
          const SizedBox(height: 21),
          BaseContainer(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const QrCodeInfoCard(
                  title: 'Website URL',
                  url: 'www.example.com/product ',
                ),
                const CustomDivider(),
                const FullContentCard(
                  content: 'https://www.example.com/product/special-offer-2024',
                ),
                const CustomDivider(),
                const QrCodeMetadata(scannedTime: 'Just now', type: 'URL'),
              ],
            ),
          ),
          const SizedBox(height: 21),
          OpenLinkButton(
            onPressed: () {
              // TODO: Add open link action
            },
          ),
          const SizedBox(height: 13),
          ActionButtonsRow(
            onCopy: () {
              // TODO: Add copy action
            },
            onShare: () {
              // TODO: Add share action
            },
            onSave: () {
              // TODO: Add save action
            },
          ),
        ],
      ),
    );
  }
}
