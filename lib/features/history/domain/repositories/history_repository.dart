import '../models/history_group_model.dart';
import '../models/history_item_model.dart';

abstract class HistoryRepository {
  Future<List<HistoryItemModel>> getHistory({String? categoryId});
  Future<List<HistoryGroupModel>> getHistoryGrouped({String? categoryId});
  Future<void> deleteQrCode(String id);
  Future<void> clearHistory();
}
