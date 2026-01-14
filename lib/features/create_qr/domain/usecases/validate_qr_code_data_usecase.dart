import '../models/qr_code_creation_data.dart';

class ValidateQrCodeDataUseCase {
  ValidateQrCodeDataUseCase();

  bool execute(QrCodeCreationData data) {
    if (data.data.trim().isEmpty) {
      return false;
    }

    switch (data.contentType) {
      case 'url':
        return _validateUrl(data.data);
      case 'text':
        return data.data.trim().isNotEmpty;
      case 'wifi':
        return _validateWifi(data.data);
      case 'contact':
        return _validateContact(data.data);
      default:
        return false;
    }
  }

  bool _validateUrl(String url) {
    if (url.trim().isEmpty) return false;
    try {
      final uri = Uri.parse(url);
      if (uri.hasScheme) {
        return uri.scheme == 'http' || uri.scheme == 'https';
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  bool _validateWifi(String data) {
    final parts = data.split(':');
    return parts.length >= 2 && parts[0].trim().isNotEmpty;
  }

  bool _validateContact(String data) {
    final parts = data.split(':');
    return parts.isNotEmpty && parts[0].trim().isNotEmpty;
  }
}
