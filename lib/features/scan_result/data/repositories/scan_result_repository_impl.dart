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

  @override
  Future<List<QrCodeData>> getAllQrCodes() async {
    return await _localDataSource.getAllQrCodes();
  }

  @override
  Future<List<QrCodeData>> getRecentQrCodes({int limit = 10}) async {
    return await _localDataSource.getRecentQrCodes(limit: limit);
  }

  @override
  Future<void> deleteQrCode(String rawData) async {
    await _localDataSource.deleteQrCode(rawData);
  }

  @override
  Future<void> clearAllQrCodes() async {
    await _localDataSource.clearAllQrCodes();
  }
}
