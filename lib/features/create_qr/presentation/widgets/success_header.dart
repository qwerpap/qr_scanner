import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';

class SuccessHeader extends StatelessWidget {
  const SuccessHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: Image.asset(
            ImageSource.success,
            height: 120,
            width: 120,
          ),
        ),
        Center(
          child: Text(
            context.l10n.theQrCodeIsReady,
            style: AppFonts.titleLarge,
          ),
        ),
      ],
    );
  }
}
