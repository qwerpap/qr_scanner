import '../entities/qr_code_type.dart';

abstract class ScanResultRepository {
  Future<void> saveQrCode(QrCodeData qrCodeData);
  Future<List<QrCodeData>> getAllQrCodes();
  Future<List<QrCodeData>> getRecentQrCodes({int limit = 10});
}
