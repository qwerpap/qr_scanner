import 'package:qr_scanner/core/constants/image_source.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';
import 'package:qr_scanner/features/history/data/models/history_group_model.dart';
import 'package:qr_scanner/features/history/data/models/history_item_model.dart';

class HistoryData {
  static final List<HistoryGroupModel> groups = [
    HistoryGroupModel(
      date: 'Today',
      items: [
        HistoryItemModel(
          id: '1',
          title: 'Website Link',
          content: 'https://example.com/proc',
          type: 'scanned',
          status: 'Scanned',
          timestamp: '2:30 PM',
          iconPath: ImageSource.scannedQr,
          iconColor: AppColors.primaryColor.value,
        ),
        HistoryItemModel(
          id: '2',
          title: 'WiFi Network',
          content: 'Home_WiFi_5G',
          type: 'created',
          status: 'Created',
          timestamp: '1:15 PM',
          iconPath: ImageSource.scannedQr,
          iconColor: AppColors.greenColor.value,
        ),
        HistoryItemModel(
          id: '3',
          title: 'Text Message',
          content: 'Meeting at 3 PM in confei',
          type: 'scanned',
          status: 'Scanned',
          timestamp: '2:15 PM',
          iconPath: ImageSource.scannedQr,
          iconColor: AppColors.primaryColor.value,
        ),
      ],
    ),
    HistoryGroupModel(
      date: 'Yesterday',
      items: [
        HistoryItemModel(
          id: '4',
          title: 'Contact Info',
          content: 'John Smith - Business',
          type: 'created',
          status: 'Created',
          timestamp: '11:45 AM',
          iconPath: ImageSource.scannedQr,
          iconColor: AppColors.greenColor.value,
        ),
      ],
    ),
  ];
}
