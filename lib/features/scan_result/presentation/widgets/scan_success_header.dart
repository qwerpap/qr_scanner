import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';

class ScanSuccessHeader extends StatelessWidget {
  const ScanSuccessHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(ImageSource.success, height: 100, width: 100),
        const SizedBox(height: 16),
        Text('Scan Successful', style: AppFonts.titleLarge),
        const SizedBox(height: 3),
        Text('QR code decoded successfully', style: AppFonts.titleMedium),
      ],
    );
  }
}
