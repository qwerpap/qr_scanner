import '../../../scan_result/domain/entities/qr_code_type.dart';

abstract class HomeRepository {
  Future<List<QrCodeData>> getRecentActivities({int limit = 10});
  Future<int> getSavedQrCodesCount();
}
