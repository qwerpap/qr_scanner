import '../../../scan_result/domain/entities/qr_code_type.dart';
import '../../../scan_result/domain/repositories/scan_result_repository.dart';
import '../models/created_qr_code_model.dart';
import '../repositories/my_qr_codes_repository.dart';

class SaveCreatedQrCodeUseCase {
  final MyQrCodesRepository _repository;
  final ScanResultRepository _scanResultRepository;

  SaveCreatedQrCodeUseCase({
    required MyQrCodesRepository repository,
    required ScanResultRepository scanResultRepository,
  })  : _repository = repository,
        _scanResultRepository = scanResultRepository;

  Future<void> call(CreatedQrCodeModel qrCode) async {
    await _repository.saveCreatedQrCode(qrCode);
    
    // Also save to history with isCreated flag
    final qrCodeData = QrCodeData(
      rawData: qrCode.rawData,
      type: qrCode.type,
      scannedAt: qrCode.createdAt,
      title: qrCode.title,
      url: qrCode.type == QrCodeType.url ? qrCode.rawData : null,
      isCreated: true,
    );
    await _scanResultRepository.saveQrCode(qrCodeData);
  }
}
