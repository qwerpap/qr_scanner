import '../../../../core/utils/qr_code_type_detector.dart';
import '../entities/qr_code_type.dart';

class DetectQrCodeTypeUseCase {
  DetectQrCodeTypeUseCase();

  QrCodeData execute(String rawData) {
    final type = QrCodeTypeDetector.detectType(rawData);
    final scannedAt = DateTime.now();

    String? url;
    if (type == QrCodeType.url) {
      url = rawData;
    }

    return QrCodeData(
      rawData: rawData,
      type: type,
      scannedAt: scannedAt,
      url: url,
    );
  }
}
