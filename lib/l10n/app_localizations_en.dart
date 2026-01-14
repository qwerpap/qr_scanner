// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'QR Scanner';

  @override
  String get welcome => 'Welcome!';

  @override
  String welcomeWithName(String name) {
    return 'Welcome, $name!';
  }

  @override
  String get scanQrCode => 'Scan QR Code';

  @override
  String get createQrCode => 'Create QR Code';

  @override
  String get myQrCodes => 'My QR Codes';

  @override
  String get history => 'History';

  @override
  String get profile => 'Profile';

  @override
  String get retry => 'Retry';

  @override
  String get error => 'Error';

  @override
  String get processing => 'Processing...';

  @override
  String get continueText => 'Continue';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get and => 'and';

  @override
  String get subscriptionPurchasedSuccessfully =>
      'Subscription purchased successfully!';

  @override
  String get purchasesRestoredSuccessfully =>
      'Purchases restored successfully!';

  @override
  String get noProductsAvailable =>
      'No products available. Please check your internet connection and try again.';

  @override
  String get noInternetConnection =>
      'No internet connection. Please check your network and try again.';

  @override
  String get productsTemporarilyUnavailable =>
      'Products are temporarily unavailable. Please try again later.';

  @override
  String get failedToLoadProducts =>
      'Failed to load products. Please check your internet connection and try again.';

  @override
  String get copiedToClipboard => 'Copied to clipboard';

  @override
  String get savedSuccessfully => 'Saved successfully';

  @override
  String get sharedSuccessfully => 'Shared successfully';

  @override
  String get noQrFoundInImage => 'No QR code found in image';

  @override
  String get cannotOpenUrl => 'Cannot open URL';

  @override
  String get simulatorNotSupported =>
      'Image scanning is not available on iOS Simulator. Please use a real device.';

  @override
  String get cameraUnavailable => 'Camera Unavailable';

  @override
  String get cameraNotAvailableOnSimulator =>
      'Camera not available\non iOS Simulator';

  @override
  String get cameraAccessDenied => 'Camera Access Denied';

  @override
  String get cameraPermissionDenied =>
      'Camera permission denied.\nPlease enable it in Settings.';

  @override
  String get cameraPermissionRequired => 'Camera Permission Required';

  @override
  String get cameraPermissionRequiredToScan =>
      'Camera permission required\nto scan QR codes';

  @override
  String get initializingCamera => 'Initializing camera...';

  @override
  String get initializingCameraTitle => 'Initializing Camera';

  @override
  String get cameraPermissionRequiredText => 'Camera permission required';

  @override
  String get loadingCamera => 'Loading camera...';

  @override
  String get useGalleryButtonToScan =>
      'Use Gallery button to scan QR from photos';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get requestPermission => 'Request Permission';

  @override
  String get pleaseEnableCameraPermission =>
      'Please enable camera permission\nin Settings';

  @override
  String get restorePurchases => 'Restore Purchases';

  @override
  String get autoRenewableCancelAnytime => 'Auto-renewable. Cancel anytime.';

  @override
  String get retryButton => 'Retry';

  @override
  String get manageYourQrCodesEasily => 'Manage your QR codes easily';

  @override
  String get home => 'Home';

  @override
  String get scan => 'Scan';

  @override
  String get scanQr => 'Scan QR';

  @override
  String get quickScan => 'Quick scan';

  @override
  String get createQr => 'Create QR';

  @override
  String get generateNew => 'Generate new';

  @override
  String get myQrCodesTitle => 'My QR Codes';

  @override
  String get savedCodes => 'Saved codes';

  @override
  String get historyTitle => 'History';

  @override
  String get recentScans => 'Recent scans';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get russian => 'Russian';

  @override
  String get next => 'Next';

  @override
  String get skip => 'Skip';

  @override
  String get getStarted => 'Get Started';

  @override
  String get onboardingWelcomeTitle => 'Welcome';

  @override
  String get onboardingWelcomeBold => 'Scan, Create & Manage QR Codes Easily';

  @override
  String get onboardingScanTitle => 'Scan QR Codes';

  @override
  String get onboardingScanBold => 'Quickly Scan Any QR Code';

  @override
  String get onboardingScanRegular =>
      'Align QR codes in frame and get instant\nresults';

  @override
  String get onboardingCreateTitle => 'Create QR Codes';

  @override
  String get onboardingCreateBold => 'Generate QR Codes Instantly';

  @override
  String get onboardingCreateRegular =>
      'Enter URL, text, or contact info and get\nyour custom QR';

  @override
  String get onboardingManageTitle => 'Manage & Share';

  @override
  String get onboardingManageBold => 'Save, Share, and Track All Your QR Codes';

  @override
  String get onboardingManageRegular =>
      'Access My QR Codes and History anytime';

  @override
  String get subscription => 'Subscription';

  @override
  String get active => 'Active';

  @override
  String get free => 'Free';

  @override
  String get upgradeToPremium => 'Upgrade to Premium';

  @override
  String get upgradeToPremiumToUnlock =>
      'Upgrade to Premium to unlock all features';

  @override
  String get yourSubscriptionIsActive => 'Your subscription is active';

  @override
  String get expiresNever => 'Expires: Never';

  @override
  String get editQrCode => 'Edit QR Code';

  @override
  String get scanSuccessful => 'Scan Successful';

  @override
  String get qrCodeDecodedSuccessfully => 'QR code decoded successfully';

  @override
  String get contentType => 'Content Type';

  @override
  String get designOptions => 'Design Options';

  @override
  String get color => 'Color';

  @override
  String get websiteUrl => 'Website URL';

  @override
  String get fullContent => 'Full Content';

  @override
  String get scanned => 'Scanned';

  @override
  String get type => 'Type';

  @override
  String get scanResult => 'Scan Result';

  @override
  String get noQrCodeData => 'No QR code data';

  @override
  String get goBack => 'Go Back';

  @override
  String get goToMyQrCodes => 'Go to My QR Codes';

  @override
  String get gallery => 'Gallery';

  @override
  String get camera => 'Camera';

  @override
  String get deleteQrCode => 'Delete QR Code';

  @override
  String get clearHistory => 'Clear History';

  @override
  String get all => 'All';

  @override
  String get scannedCategory => 'Scanned';

  @override
  String get createdCategory => 'Created';

  @override
  String get urlCategory => 'URL';

  @override
  String get textCategory => 'Text';

  @override
  String get wifiCategory => 'WiFi';

  @override
  String get contactCategory => 'Contact';

  @override
  String get unlimitedQrScans => 'Unlimited QR Scans';

  @override
  String get scanAsManyQrCodesAsYouWant => 'Scan as many QR codes as you want';

  @override
  String get createAllQrTypes => 'Create All QR Types';

  @override
  String get urlTextContactWifiAndMore => 'URL, Text, Contact, WiFi, and more';

  @override
  String get noAds => 'No Ads';

  @override
  String get cleanDistractionFreeExperience =>
      'Clean, distraction-free experience';

  @override
  String get cloudBackup => 'Cloud Backup';

  @override
  String get syncAcrossAllYourDevices => 'Sync across all your devices';

  @override
  String get advancedAnalytics => 'Advanced Analytics';

  @override
  String get trackScansAndUsagePatterns => 'Track scans and usage patterns';

  @override
  String get recentActivity => 'Recent Activity';

  @override
  String get delete => 'Delete';

  @override
  String get cancel => 'Cancel';

  @override
  String get clear => 'Clear';

  @override
  String get areYouSureYouWantToDeleteThisQrCode =>
      'Are you sure you want to delete this QR code?';

  @override
  String get areYouSureYouWantToClearAllHistory =>
      'Are you sure you want to clear all history? This action cannot be undone.';

  @override
  String get unlockFullQrTools => 'Unlock Full QR\nTools';

  @override
  String get unlimitedScansCustomQrCreationAndFullHistoryAccess =>
      'Unlimited scans, custom QR creation, and full history access.';

  @override
  String get restore => 'Restore';

  @override
  String get week => 'week';

  @override
  String get month => 'month';

  @override
  String get year => 'year';

  @override
  String get threeDayFreeTrial => '3-day free trial';

  @override
  String get cancelAnytime => 'Cancel anytime';

  @override
  String get bestValueOption => 'Best value option';

  @override
  String get mostPopular => 'MOST POPULAR';

  @override
  String get save => 'Save';

  @override
  String savePercent(String percent) {
    return 'SAVE $percent%';
  }

  @override
  String get alignQrCodeWithinFrame => 'Align QR code within frame';

  @override
  String get keepYourDeviceSteady => 'Keep your device steady';

  @override
  String get flash => 'Flash';

  @override
  String get switchCamera => 'Switch';

  @override
  String get addLogo => 'Add Logo';

  @override
  String get logoAdded => 'Logo Added';

  @override
  String get proFeature => 'Pro Feature';

  @override
  String get updateQrCode => 'Update QR Code';

  @override
  String get generateQrCode => 'Generate QR Code';

  @override
  String get contactName => 'Contact Name';

  @override
  String get enterContactName => 'Enter contact name...';

  @override
  String get enterText => 'Enter text...';

  @override
  String get theQrCodeIsReady => 'The QR code is ready';

  @override
  String get share => 'Share';

  @override
  String get searchQrCodes => 'Search QR codes...';

  @override
  String get noQrCodesYet => 'No QR codes yet';

  @override
  String get justNow => 'Just now';

  @override
  String minuteAgo(int count) {
    return '$count minute ago';
  }

  @override
  String minutesAgo(int count) {
    return '$count minutes ago';
  }

  @override
  String hourAgo(int count) {
    return '$count hour ago';
  }

  @override
  String hoursAgo(int count) {
    return '$count hours ago';
  }

  @override
  String dayAgo(int count) {
    return '$count day ago';
  }

  @override
  String daysAgo(int count) {
    return '$count days ago';
  }

  @override
  String get monthJan => 'Jan';

  @override
  String get monthFeb => 'Feb';

  @override
  String get monthMar => 'Mar';

  @override
  String get monthApr => 'Apr';

  @override
  String get monthMay => 'May';

  @override
  String get monthJun => 'Jun';

  @override
  String get monthJul => 'Jul';

  @override
  String get monthAug => 'Aug';

  @override
  String get monthSep => 'Sep';

  @override
  String get monthOct => 'Oct';

  @override
  String get monthNov => 'Nov';

  @override
  String get monthDec => 'Dec';
}
