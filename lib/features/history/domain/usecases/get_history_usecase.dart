import '../models/history_group_model.dart';
import '../repositories/history_repository.dart';

class GetHistoryUseCase {
  final HistoryRepository repository;

  GetHistoryUseCase(this.repository);

  Future<List<HistoryGroupModel>> execute({String? categoryId}) async {
    return await repository.getHistoryGrouped(categoryId: categoryId);
  }
}
