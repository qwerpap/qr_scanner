import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';

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
            'The QR code is ready',
            style: AppFonts.titleLarge,
          ),
        ),
      ],
    );
  }
}
