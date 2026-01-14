import 'package:equatable/equatable.dart';

class HistoryItemModel extends Equatable {
  const HistoryItemModel({
    required this.id,
    required this.title,
    required this.content,
    required this.type,
    required this.status,
    required this.timestamp,
    required this.iconData,
    required this.iconColor,
    required this.qrData,
  });

  final String id;
  final String title;
  final String content;
  final String type; // 'scanned', 'created'
  final String status; // 'Scanned', 'Created'
  final String timestamp; // '2:30 PM'
  final int iconData; // IconData codePoint
  final int iconColor; // Color value as int
  final String qrData;

  @override
  List<Object?> get props => [
        id,
        title,
        content,
        type,
        status,
        timestamp,
        iconData,
        iconColor,
        qrData,
      ];
}
