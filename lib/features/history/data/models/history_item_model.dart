import 'package:equatable/equatable.dart';

class HistoryItemModel extends Equatable {
  const HistoryItemModel({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.status,
    required this.timestamp,
    required this.iconPath,
    required this.iconColor,
  });

  final String id;
  final String title;
  final String content;
  final String type; // 'scanned', 'created'
  final String status; // 'Scanned', 'Created'
  final String timestamp; // '2:30 PM'
  final String iconPath;
  final int iconColor; // Color value as int

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        type,
        status,
        timestamp,
        iconPath,
        iconColor,
      ];
}
