import 'package:qr_scanner/core/utils/date_utils.dart';
import '../../../scan_result/domain/entities/qr_code_type.dart';
import '../../domain/models/history_group_model.dart';
import '../mappers/qr_code_to_history_item_mapper.dart';

class HistoryGroupUtils {
  HistoryGroupUtils._();

  static List<HistoryGroupModel> groupQrCodesByDate(List<QrCodeData> qrCodes) {
    if (qrCodes.isEmpty) return [];

    final grouped = <String, List<QrCodeData>>{};

    for (final qrCode in qrCodes) {
      final dateKey = DateUtils.formatDate(qrCode.scannedAt);

      if (!grouped.containsKey(dateKey)) {
        grouped[dateKey] = [];
      }
      grouped[dateKey]!.add(qrCode);
    }

    final groups = grouped.entries.map((entry) {
      final items = entry.value.map(QrCodeToHistoryItemMapper.map).toList();
      return HistoryGroupModel(date: entry.key, items: items);
    }).toList();

    groups.sort((a, b) {
      final dateA = _parseDate(a.date);
      final dateB = _parseDate(b.date);
      return dateB.compareTo(dateA);
    });

    return groups;
  }

  static DateTime _parseDate(String dateStr) {
    if (dateStr == 'Today') {
      return DateTime.now();
    } else if (dateStr == 'Yesterday') {
      return DateTime.now().subtract(const Duration(days: 1));
    } else {
      try {
        final parts = dateStr.split('/');
        if (parts.length == 3) {
          return DateTime(
            int.parse(parts[2]),
            int.parse(parts[1]),
            int.parse(parts[0]),
          );
        }
      } catch (_) {
        // ignore
      }
    }
    return DateTime.now();
  }
}
