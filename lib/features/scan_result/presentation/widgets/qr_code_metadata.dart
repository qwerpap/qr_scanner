import 'package:flutter/material.dart';
import 'package:qr_scanner/features/scan_result/presentation/widgets/result_column_text.dart';

class QrCodeMetadata extends StatelessWidget {
  const QrCodeMetadata({
    super.key,
    required this.scannedTime,
    required this.type,
  });

  final String scannedTime;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ResultColumnText(title: 'Scanned', subtitle: scannedTime),
        ResultColumnText(title: 'Type', subtitle: type),
      ],
    );
  }
}
