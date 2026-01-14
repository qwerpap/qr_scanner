import 'package:flutter/material.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';
import 'package:qr_scanner/core/utils/time_formatter.dart';
import '../../../scan_result/domain/entities/qr_code_type.dart';
import '../../domain/models/recent_activity_model.dart';

class QrCodeToRecentActivityMapper {
  QrCodeToRecentActivityMapper._();

  static RecentActivityModel map(QrCodeData qrCodeData) {
    final timestamp = TimeFormatter.formatScannedTime(qrCodeData.scannedAt);
    final title = _getTitle(qrCodeData);
    final color = _getColor(qrCodeData.type);
    final iconData = _getIcon(qrCodeData.type);

    return RecentActivityModel(
      title: title,
      timestamp: timestamp,
      iconData: iconData,
      color: color,
      qrData: qrCodeData.rawData,
    );
  }

  static String _getTitle(QrCodeData qrCodeData) {
    final type = qrCodeData.type;
    switch (type) {
      case QrCodeType.url:
        return 'Scanned website link';
      case QrCodeType.wifi:
        return 'Scanned WiFi QR';
      case QrCodeType.vcard:
        return 'Scanned contact QR';
      case QrCodeType.email:
        return 'Scanned email';
      case QrCodeType.phone:
        return 'Scanned phone number';
      case QrCodeType.sms:
        return 'Scanned SMS';
      case QrCodeType.text:
        return 'Scanned text QR';
      case QrCodeType.unknown:
        return 'Scanned QR code';
    }
  }

  static IconData _getIcon(QrCodeType type) {
    switch (type) {
      case QrCodeType.url:
        return Icons.link;
      case QrCodeType.wifi:
        return Icons.wifi;
      case QrCodeType.vcard:
        return Icons.contact_page;
      case QrCodeType.email:
        return Icons.email;
      case QrCodeType.phone:
        return Icons.phone;
      case QrCodeType.sms:
        return Icons.sms;
      case QrCodeType.text:
        return Icons.qr_code_scanner;
      case QrCodeType.unknown:
        return Icons.qr_code_scanner;
    }
  }

  static Color _getColor(QrCodeType type) {
    switch (type) {
      case QrCodeType.url:
        return AppColors.primaryColor;
      case QrCodeType.wifi:
        return AppColors.greenColor;
      case QrCodeType.vcard:
        return AppColors.orangeColor;
      case QrCodeType.email:
        return AppColors.primaryColor;
      case QrCodeType.phone:
        return AppColors.primaryColor;
      case QrCodeType.sms:
        return AppColors.primaryColor;
      case QrCodeType.text:
        return AppColors.primaryColor;
      case QrCodeType.unknown:
        return AppColors.primaryColor;
    }
  }
}
