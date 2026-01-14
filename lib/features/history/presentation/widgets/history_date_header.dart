import 'package:flutter/material.dart';
import 'package:qr_scanner/core/theme/app_fonts.dart';

class HistoryDateHeader extends StatelessWidget {
  const HistoryDateHeader({
    super.key,
    required this.date,
  });

  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Text(
        date,
        style: AppFonts.displayMedium.copyWith(fontSize: 22),
      ),
    );
  }
}
