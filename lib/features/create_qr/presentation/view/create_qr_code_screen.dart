import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner/core/shared/widgets/custom_elevated_button.dart';
import 'package:qr_scanner/core/shared/widgets/custom_sliver_app_bar.dart';
import 'package:qr_scanner/features/create_qr/data/constants/content_types_data.dart';
import 'package:qr_scanner/features/create_qr/presentation/widgets/content_type_section.dart';
import 'package:qr_scanner/features/create_qr/presentation/widgets/design_options_section.dart';
import 'package:qr_scanner/features/create_qr/presentation/widgets/website_url_section.dart';
import 'package:qr_scanner/features/create_qr/presentation/widgets/wifi_button.dart';

class CreateQrCodeScreen extends StatefulWidget {
  const CreateQrCodeScreen({super.key});

  @override
  State<CreateQrCodeScreen> createState() => _CreateQrCodeScreenState();
}

class _CreateQrCodeScreenState extends State<CreateQrCodeScreen> {
  String _selectedTypeId = ContentTypesData.types.first.id;

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
                ContentTypeSection(
                  selectedTypeId: _selectedTypeId,
                  onTypeSelected: (typeId) {
                    setState(() {
                      _selectedTypeId = typeId;
                    });
                  },
                ),
                const SizedBox(height: 24),
                const WifiButton(),
                const SizedBox(height: 40),
                const WebsiteUrlSection(),
                const SizedBox(height: 17.5),
                const DesignOptionsSection(),
                const SizedBox(height: 17),
                CustomElevatedButton(
                  onPressed: () {
                    context.go('/qr_code_ready');
                  },
                  title: 'Generate QR Code',
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
