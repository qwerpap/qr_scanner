import 'package:flutter/material.dart';
import 'package:qr_scanner/core/shared/widgets/custom_sliver_app_bar.dart';
import 'package:qr_scanner/core/shared/widgets/qr_code_section.dart';
import 'package:qr_scanner/features/create_qr/presentation/widgets/qr_ready_action_buttons.dart';
import 'package:qr_scanner/features/create_qr/presentation/widgets/success_header.dart';

class QrCodeReadyScreen extends StatelessWidget {
  const QrCodeReadyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(
            title: 'Create QR Code',
            showCloseButton: true,
            showDivider: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SuccessHeader(),
                const SizedBox(height: 27),
                const Center(child: QrCodeSection(hasPermission: false)),
                const SizedBox(height: 40),
                QrReadyActionButtons(
                  onShareTap: () {
                    // TODO: Implement share
                  },
                  onSaveTap: () {
                    // TODO: Implement save
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
