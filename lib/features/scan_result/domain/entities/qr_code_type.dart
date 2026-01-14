import 'package:equatable/equatable.dart';

enum QrCodeType {
  url,
  text,
  email,
  phone,
  wifi,
  sms,
  vcard,
  unknown;

  String get displayName {
    switch (this) {
      case QrCodeType.url:
        return 'URL';
      case QrCodeType.text:
        return 'Text';
      case QrCodeType.email:
        return 'Email';
      case QrCodeType.phone:
        return 'Phone';
      case QrCodeType.wifi:
        return 'WiFi';
      case QrCodeType.sms:
        return 'SMS';
      case QrCodeType.vcard:
        return 'Contact';
      case QrCodeType.unknown:
        return 'Unknown';
    }
  }

  String get iconPath {
    switch (this) {
      case QrCodeType.url:
        return 'assets/svg/link.svg';
      case QrCodeType.text:
        return 'assets/svg/scanned_qr.svg';
      case QrCodeType.email:
        return 'assets/svg/scanned_qr.svg';
      case QrCodeType.phone:
        return 'assets/svg/scanned_qr.svg';
      case QrCodeType.wifi:
        return 'assets/svg/scanned_qr.svg';
      case QrCodeType.sms:
        return 'assets/svg/scanned_qr.svg';
      case QrCodeType.vcard:
        return 'assets/svg/scanned_qr.svg';
      case QrCodeType.unknown:
        return 'assets/svg/scanned_qr.svg';
    }
  }
}

class QrCodeData extends Equatable {
  final String rawData;
  final QrCodeType type;
  final DateTime scannedAt;
  final String? title;
  final String? url;
  final bool isCreated;

  const QrCodeData({
    required this.rawData,
    required this.type,
    required this.scannedAt,
    this.title,
    this.url,
    this.isCreated = false,
  });

  String get displayTitle {
    if (title != null) return title!;
    switch (type) {
      case QrCodeType.url:
        return 'Website URL';
      case QrCodeType.text:
        return 'Text Message';
      case QrCodeType.email:
        return 'Email Address';
      case QrCodeType.phone:
        return 'Phone Number';
      case QrCodeType.wifi:
        return 'WiFi Network';
      case QrCodeType.sms:
        return 'SMS Message';
      case QrCodeType.vcard:
        return 'Contact Info';
      case QrCodeType.unknown:
        return 'QR Code';
    }
  }

  String get displayUrl {
    if (url != null) return url!;
    if (type == QrCodeType.url) {
      try {
        final uri = Uri.parse(rawData);
        return uri.host.isNotEmpty ? uri.host : rawData;
      } catch (_) {
        return rawData;
      }
    }
    return rawData;
  }

  @override
  List<Object?> get props => [rawData, type, scannedAt, title, url, isCreated];
}
