import '../entities/qr_code_type.dart';
import '../repositories/scan_result_repository.dart';

class SaveQrCodeUseCase {
  final ScanResultRepository repository;

  SaveQrCodeUseCase(this.repository);

  Future<void> execute(QrCodeData qrCodeData) async {
    await repository.saveQrCode(qrCodeData);
  }
}
