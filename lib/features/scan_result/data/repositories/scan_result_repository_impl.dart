import '../../domain/entities/qr_code_type.dart';
import '../../domain/repositories/scan_result_repository.dart';
import '../datasources/scan_result_local_datasource.dart';

class ScanResultRepositoryImpl implements ScanResultRepository {
  final ScanResultLocalDataSource _localDataSource;

  ScanResultRepositoryImpl({required ScanResultLocalDataSource localDataSource})
      : _localDataSource = localDataSource;

  @override
  Future<void> saveQrCode(QrCodeData qrCodeData) async {
    await _localDataSource.saveQrCode(qrCodeData);
  }
}
