import '../../features/scan_result/domain/entities/qr_code_type.dart';

class QrCodeTypeDetector {
  QrCodeTypeDetector._();

  static QrCodeType detectType(String data) {
    if (data.trim().isEmpty) {
      return QrCodeType.unknown;
    }

    final lowerData = data.toLowerCase().trim();

    if (_isUrl(lowerData)) {
      return QrCodeType.url;
    }

    if (_isEmail(lowerData)) {
      return QrCodeType.email;
    }

    if (_isPhone(lowerData)) {
      return QrCodeType.phone;
    }

    if (_isWifi(lowerData)) {
      return QrCodeType.wifi;
    }

    if (_isSms(lowerData)) {
      return QrCodeType.sms;
    }

    if (_isVCard(lowerData)) {
      return QrCodeType.vcard;
    }

    return QrCodeType.text;
  }

  static bool _isUrl(String data) {
    try {
      final uri = Uri.parse(data);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (_) {
      return false;
    }
  }

  static bool _isEmail(String data) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(data);
  }

  static bool _isPhone(String data) {
    final phoneRegex = RegExp(r'^\+?[\d\s\-\(\)]{7,}$');
    return phoneRegex.hasMatch(data.replaceAll(RegExp(r'[\s\-\(\)]'), ''));
  }

  static bool _isWifi(String data) {
    return data.startsWith('wifi:') || data.startsWith('wpa:');
  }

  static bool _isSms(String data) {
    return data.startsWith('sms:') || data.startsWith('smsto:');
  }

  static bool _isVCard(String data) {
    return data.startsWith('begin:vcard') || data.startsWith('vcard:');
  }
}
