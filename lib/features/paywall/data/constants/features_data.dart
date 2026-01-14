import 'package:flutter/material.dart';
import 'package:qr_scanner/core/constants/image_source.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';
import 'package:qr_scanner/features/paywall/data/models/feature_model.dart';

class FeaturesData {
  static List<FeatureModel> getFeatures(BuildContext context) {
    return [
      FeatureModel(
        id: 'unlimited_scans',
        title: context.l10n.unlimitedQrScans,
        description: context.l10n.scanAsManyQrCodesAsYouWant,
        iconPath: ImageSource.unlimited,
      ),
      FeatureModel(
        id: 'create_all_qr',
        title: context.l10n.createAllQrTypes,
        description: context.l10n.urlTextContactWifiAndMore,
        iconPath: ImageSource.allQr,
      ),
      FeatureModel(
        id: 'no_ads',
        title: context.l10n.noAds,
        description: context.l10n.cleanDistractionFreeExperience,
        iconPath: ImageSource.ads,
      ),
      FeatureModel(
        id: 'cloud_backup',
        title: context.l10n.cloudBackup,
        description: context.l10n.syncAcrossAllYourDevices,
        iconPath: ImageSource.cloud,
      ),
      FeatureModel(
        id: 'advanced_analytics',
        title: context.l10n.advancedAnalytics,
        description: context.l10n.trackScansAndUsagePatterns,
        iconPath: ImageSource.analytics,
      ),
    ];
  }
}
