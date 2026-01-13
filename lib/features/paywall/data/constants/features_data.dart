import 'package:qr_scanner/core/constants/image_source.dart';
import 'package:qr_scanner/features/paywall/data/models/feature_model.dart';

class FeaturesData {
  static const List<FeatureModel> features = [
    FeatureModel(
      id: 'unlimited_scans',
      title: 'Unlimited QR Scans',
      description: 'Scan as many QR codes as you want',
      iconPath: ImageSource.unlimited,
    ),
    FeatureModel(
      id: 'create_all_qr',
      title: 'Create All QR Types',
      description: 'URL, Text, Contact, WiFi, and more',
      iconPath: ImageSource.allQr,
    ),
    FeatureModel(
      id: 'no_ads',
      title: 'No Ads',
      description: 'Clean, distraction-free experience',
      iconPath: ImageSource.ads,
    ),
    FeatureModel(
      id: 'cloud_backup',
      title: 'Cloud Backup',
      description: 'Sync across all your devices',
      iconPath: ImageSource.cloud,
    ),
    FeatureModel(
      id: 'advanced_analytics',
      title: 'Advanced Analytics',
      description: 'Track scans and usage patterns',
      iconPath: ImageSource.analytics,
    ),
  ];
}
