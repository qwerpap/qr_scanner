import '../entities/qr_code_type.dart';

abstract class ScanResultRepository {
  Future<void> saveQrCode(QrCodeData qrCodeData);
}
