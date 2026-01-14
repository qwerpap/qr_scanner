import '../../../scan_result/domain/entities/qr_code_type.dart';
import '../../../scan_result/domain/repositories/scan_result_repository.dart';
import '../../domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  final ScanResultRepository _scanResultRepository;

  HomeRepositoryImpl({required ScanResultRepository scanResultRepository})
      : _scanResultRepository = scanResultRepository;

  @override
  Future<List<QrCodeData>> getRecentActivities({int limit = 10}) async {
    return await _scanResultRepository.getRecentQrCodes(limit: limit);
  }

  @override
  Future<int> getSavedQrCodesCount() async {
    final allCodes = await _scanResultRepository.getAllQrCodes();
    return allCodes.length;
  }
}
