import '../../../my_qr_codes/domain/models/created_qr_code_model.dart';
import '../../../scan_result/domain/entities/qr_code_type.dart';
import '../models/qr_code_creation_data.dart';

class GenerateQrCodeUseCase {
  GenerateQrCodeUseCase();

  CreatedQrCodeModel execute(QrCodeCreationData creationData) {
    final rawData = _generateRawData(creationData);
    final type = _mapContentTypeToQrCodeType(creationData.contentType);
    final title = creationData.title ?? _getDefaultTitle(type);
    final categoryId = creationData.contentType;

    return CreatedQrCodeModel(
      id: _generateId(),
      rawData: rawData,
      type: type,
      createdAt: DateTime.now(),
      title: title,
      color: creationData.color,
      hasLogo: creationData.hasLogo,
      categoryId: categoryId,
    );
  }

  String _generateRawData(QrCodeCreationData creationData) {
    switch (creationData.contentType) {
      case 'url':
        return _ensureUrlFormat(creationData.data);
      case 'text':
        return creationData.data;
      case 'wifi':
        return _generateWifiData(creationData.data);
      case 'contact':
        return _generateContactData(creationData.data);
      default:
        return creationData.data;
    }
  }

  String _ensureUrlFormat(String url) {
    if (url.trim().isEmpty) return url;
    final trimmed = url.trim();
    if (trimmed.startsWith('http://') || trimmed.startsWith('https://')) {
      return trimmed;
    }
    return 'https://$trimmed';
  }

  String _generateWifiData(String data) {
    // Data format: "ssid:password:securityType"
    final parts = data.split(':');
    if (parts.length >= 3) {
      final ssid = parts[0];
      final password = parts[1];
      final security = parts[2].toUpperCase();
      return 'WIFI:T:$security;S:$ssid;P:$password;;';
    }
    return data;
  }

  String _generateContactData(String data) {
    // Simple vCard format - just name for now
    // Can be extended later with full contact form
    final name = data.trim();
    if (name.isEmpty) return '';

    final buffer = StringBuffer();
    buffer.writeln('BEGIN:VCARD');
    buffer.writeln('VERSION:3.0');
    buffer.writeln('FN:$name');
    buffer.writeln('END:VCARD');
    return buffer.toString();
  }

  QrCodeType _mapContentTypeToQrCodeType(String contentType) {
    switch (contentType) {
      case 'url':
        return QrCodeType.url;
      case 'text':
        return QrCodeType.text;
      case 'wifi':
        return QrCodeType.wifi;
      case 'contact':
        return QrCodeType.vcard;
      default:
        return QrCodeType.text;
    }
  }

  String _getDefaultTitle(QrCodeType type) {
    switch (type) {
      case QrCodeType.url:
        return 'Website URL';
      case QrCodeType.text:
        return 'Text Message';
      case QrCodeType.wifi:
        return 'WiFi Network';
      case QrCodeType.vcard:
        return 'Contact Info';
      default:
        return 'QR Code';
    }
  }

  String _generateId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}
