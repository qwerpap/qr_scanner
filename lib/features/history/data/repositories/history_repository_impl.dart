import '../../../scan_result/domain/repositories/scan_result_repository.dart';
import '../../domain/models/history_group_model.dart';
import '../../domain/models/history_item_model.dart';
import '../../domain/repositories/history_repository.dart';
import '../mappers/qr_code_to_history_item_mapper.dart';
import '../utils/history_group_utils.dart';

class HistoryRepositoryImpl implements HistoryRepository {
  final ScanResultRepository _scanResultRepository;

  HistoryRepositoryImpl({required ScanResultRepository scanResultRepository})
      : _scanResultRepository = scanResultRepository;

  @override
  Future<List<HistoryItemModel>> getHistory({String? categoryId}) async {
    final allCodes = await _scanResultRepository.getAllQrCodes();
    var filteredCodes = allCodes;

    if (categoryId != null && categoryId != 'all') {
      if (categoryId == 'scanned') {
        filteredCodes = allCodes.where((code) => !code.isCreated).toList();
      } else if (categoryId == 'created') {
        filteredCodes = allCodes.where((code) => code.isCreated).toList();
      }
    }

    return filteredCodes
        .map(QrCodeToHistoryItemMapper.map)
        .toList();
  }

  @override
  Future<List<HistoryGroupModel>> getHistoryGrouped({String? categoryId}) async {
    final qrCodes = await _scanResultRepository.getAllQrCodes();
    
    var filteredCodes = qrCodes;
    if (categoryId != null && categoryId != 'all') {
      if (categoryId == 'scanned') {
        filteredCodes = qrCodes.where((code) => !code.isCreated).toList();
      } else if (categoryId == 'created') {
        filteredCodes = qrCodes.where((code) => code.isCreated).toList();
      }
    }

    return HistoryGroupUtils.groupQrCodesByDate(filteredCodes);
  }

  @override
  Future<void> deleteQrCode(String id) async {
    final rawData = _extractRawDataFromId(id);
    await _scanResultRepository.deleteQrCode(rawData);
  }

  @override
  Future<void> clearHistory() async {
    await _scanResultRepository.clearAllQrCodes();
  }

  String _extractRawDataFromId(String id) {
    final parts = id.split('_');
    if (parts.length > 1) {
      return parts.sublist(0, parts.length - 1).join('_');
    }
    return id;
  }
}
