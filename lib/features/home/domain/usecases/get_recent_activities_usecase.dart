import '../../../scan_result/domain/entities/qr_code_type.dart';
import '../repositories/home_repository.dart';

class GetRecentActivitiesUseCase {
  final HomeRepository repository;

  GetRecentActivitiesUseCase(this.repository);

  Future<List<QrCodeData>> execute({int limit = 10}) async {
    return await repository.getRecentActivities(limit: limit);
  }
}
