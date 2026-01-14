import '../../../scan_result/domain/entities/qr_code_type.dart';
import '../../../scan_result/domain/repositories/scan_result_repository.dart';
import '../models/created_qr_code_model.dart';
import '../repositories/my_qr_codes_repository.dart';

class UpdateCreatedQrCodeUseCase {
  final MyQrCodesRepository repository;
  final ScanResultRepository scanResultRepository;

  UpdateCreatedQrCodeUseCase({
    required this.repository,
    required this.scanResultRepository,
  });

  Future<void> execute(CreatedQrCodeModel qrCode) async {
    await repository.updateQrCode(qrCode);
    
    // Also update in history
    final qrCodeData = QrCodeData(
      rawData: qrCode.rawData,
      type: qrCode.type,
      scannedAt: qrCode.createdAt,
      title: qrCode.title,
      url: qrCode.type == QrCodeType.url ? qrCode.rawData : null,
      isCreated: true,
    );
    await scanResultRepository.updateQrCode(qrCodeData);
  }
}
