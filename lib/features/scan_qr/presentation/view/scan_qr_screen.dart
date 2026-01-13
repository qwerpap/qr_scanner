import 'package:flutter/material.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/core/shared/widgets/custom_sliver_app_bar.dart';
import 'package:qr_scanner/core/shared/widgets/qr_code_section.dart';
import 'package:qr_scanner/features/scan_qr/data/constants/control_buttons_data.dart';
import 'package:qr_scanner/features/scan_qr/presentation/widgets/control_buttons_list.dart';
import 'package:qr_scanner/features/scan_qr/presentation/widgets/scan_info_card.dart';

class ScanQrScreen extends StatelessWidget {
  const ScanQrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(
            title: 'Scan QR Code',
            showDivider: false,
            showCloseButton: true,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 20),
                const ScanInfoCard(),
                const Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 40),
                    child: QrCodeSection(),
                  ),
                ),
                BaseContainer(
                  padding: const EdgeInsets.all(16),
                  child: ControlButtonsList(
                    buttons: ControlButtonsData.getButtons(
                      onFlashTap: () {
                        // TODO: Implement flash toggle
                      },
                      onSwitchTap: () {
                        // TODO: Implement camera switch
                      },
                      onGalleryTap: () {
                        // TODO: Implement gallery picker
                      },
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
