import 'package:equatable/equatable.dart';
import 'history_item_model.dart';

class HistoryGroupModel extends Equatable {
  const HistoryGroupModel({
    required this.date,
    required this.items,
  });

  final String date; // 'Today', 'Yesterday', or date string
  final List<HistoryItemModel> items;

  @override
  List<Object?> get props => [date, items];
}
