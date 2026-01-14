import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';
import '../../../scan_result/domain/entities/qr_code_type.dart';
import '../../domain/models/history_item_model.dart';

class QrCodeToHistoryItemMapper {
  QrCodeToHistoryItemMapper._();

  static HistoryItemModel map(QrCodeData qrCodeData) {
    final id = _generateId(qrCodeData);
    final title = _getTitle(qrCodeData);
    final content = _getContent(qrCodeData);
    final type = qrCodeData.isCreated ? 'created' : 'scanned';
    final status = qrCodeData.isCreated ? 'Created' : 'Scanned';
    final timestamp = _formatTime(qrCodeData.scannedAt);
    final iconData = _getIcon(qrCodeData.type).codePoint;
    final iconColor = _getColor(qrCodeData.type).value;

    return HistoryItemModel(
      id: id,
      title: title,
      content: content,
      type: type,
      status: status,
      timestamp: timestamp,
      iconData: iconData,
      iconColor: iconColor,
      qrData: qrCodeData.rawData,
    );
  }

  static String _generateId(QrCodeData qrCodeData) {
    return '${qrCodeData.rawData}_${qrCodeData.scannedAt.millisecondsSinceEpoch}';
  }

  static String _getTitle(QrCodeData qrCodeData) {
    return qrCodeData.displayTitle;
  }

  static String _getContent(QrCodeData qrCodeData) {
    final content = qrCodeData.displayUrl;
    if (content.length > 40) {
      return '${content.substring(0, 37)}...';
    }
    return content;
  }

  static String _formatTime(DateTime dateTime) {
    final formatter = DateFormat('h:mm a');
    return formatter.format(dateTime);
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
      default:
        return AppColors.primaryColor;
    }
  }
}
