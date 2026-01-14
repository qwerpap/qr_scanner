import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ru'),
  ];

  /// Application title
  ///
  /// In en, this message translates to:
  /// **'QR Scanner'**
  String get appTitle;

  /// Welcome message
  ///
  /// In en, this message translates to:
  /// **'Welcome!'**
  String get welcome;

  /// Welcome message with user name
  ///
  /// In en, this message translates to:
  /// **'Welcome, {name}!'**
  String welcomeWithName(String name);

  /// No description provided for @scanQrCode.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Code'**
  String get scanQrCode;

  /// No description provided for @createQrCode.
  ///
  /// In en, this message translates to:
  /// **'Create QR Code'**
  String get createQrCode;

  /// No description provided for @myQrCodes.
  ///
  /// In en, this message translates to:
  /// **'My QR Codes'**
  String get myQrCodes;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @retry.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retry;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @processing.
  ///
  /// In en, this message translates to:
  /// **'Processing...'**
  String get processing;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @subscriptionPurchasedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Subscription purchased successfully!'**
  String get subscriptionPurchasedSuccessfully;

  /// No description provided for @purchasesRestoredSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Purchases restored successfully!'**
  String get purchasesRestoredSuccessfully;

  /// No description provided for @noProductsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No products available. Please check your internet connection and try again.'**
  String get noProductsAvailable;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection. Please check your network and try again.'**
  String get noInternetConnection;

  /// No description provided for @productsTemporarilyUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Products are temporarily unavailable. Please try again later.'**
  String get productsTemporarilyUnavailable;

  /// No description provided for @failedToLoadProducts.
  ///
  /// In en, this message translates to:
  /// **'Failed to load products. Please check your internet connection and try again.'**
  String get failedToLoadProducts;

  /// No description provided for @copiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get copiedToClipboard;

  /// No description provided for @savedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Saved successfully'**
  String get savedSuccessfully;

  /// No description provided for @sharedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Shared successfully'**
  String get sharedSuccessfully;

  /// No description provided for @noQrFoundInImage.
  ///
  /// In en, this message translates to:
  /// **'No QR code found in image'**
  String get noQrFoundInImage;

  /// No description provided for @cannotOpenUrl.
  ///
  /// In en, this message translates to:
  /// **'Cannot open URL'**
  String get cannotOpenUrl;

  /// No description provided for @simulatorNotSupported.
  ///
  /// In en, this message translates to:
  /// **'Image scanning is not available on iOS Simulator. Please use a real device.'**
  String get simulatorNotSupported;

  /// No description provided for @cameraUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Camera Unavailable'**
  String get cameraUnavailable;

  /// No description provided for @cameraNotAvailableOnSimulator.
  ///
  /// In en, this message translates to:
  /// **'Camera not available\non iOS Simulator'**
  String get cameraNotAvailableOnSimulator;

  /// No description provided for @cameraAccessDenied.
  ///
  /// In en, this message translates to:
  /// **'Camera Access Denied'**
  String get cameraAccessDenied;

  /// No description provided for @cameraPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Camera permission denied.\nPlease enable it in Settings.'**
  String get cameraPermissionDenied;

  /// No description provided for @cameraPermissionRequired.
  ///
  /// In en, this message translates to:
  /// **'Camera Permission Required'**
  String get cameraPermissionRequired;

  /// No description provided for @cameraPermissionRequiredToScan.
  ///
  /// In en, this message translates to:
  /// **'Camera permission required\nto scan QR codes'**
  String get cameraPermissionRequiredToScan;

  /// No description provided for @initializingCamera.
  ///
  /// In en, this message translates to:
  /// **'Initializing camera...'**
  String get initializingCamera;

  /// No description provided for @initializingCameraTitle.
  ///
  /// In en, this message translates to:
  /// **'Initializing Camera'**
  String get initializingCameraTitle;

  /// No description provided for @cameraPermissionRequiredText.
  ///
  /// In en, this message translates to:
  /// **'Camera permission required'**
  String get cameraPermissionRequiredText;

  /// No description provided for @loadingCamera.
  ///
  /// In en, this message translates to:
  /// **'Loading camera...'**
  String get loadingCamera;

  /// No description provided for @useGalleryButtonToScan.
  ///
  /// In en, this message translates to:
  /// **'Use Gallery button to scan QR from photos'**
  String get useGalleryButtonToScan;

  /// No description provided for @openSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get openSettings;

  /// No description provided for @requestPermission.
  ///
  /// In en, this message translates to:
  /// **'Request Permission'**
  String get requestPermission;

  /// No description provided for @pleaseEnableCameraPermission.
  ///
  /// In en, this message translates to:
  /// **'Please enable camera permission\nin Settings'**
  String get pleaseEnableCameraPermission;

  /// No description provided for @restorePurchases.
  ///
  /// In en, this message translates to:
  /// **'Restore Purchases'**
  String get restorePurchases;

  /// No description provided for @autoRenewableCancelAnytime.
  ///
  /// In en, this message translates to:
  /// **'Auto-renewable. Cancel anytime.'**
  String get autoRenewableCancelAnytime;

  /// No description provided for @retryButton.
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get retryButton;

  /// No description provided for @manageYourQrCodesEasily.
  ///
  /// In en, this message translates to:
  /// **'Manage your QR codes easily'**
  String get manageYourQrCodesEasily;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @scan.
  ///
  /// In en, this message translates to:
  /// **'Scan'**
  String get scan;

  /// No description provided for @scanQr.
  ///
  /// In en, this message translates to:
  /// **'Scan QR'**
  String get scanQr;

  /// No description provided for @quickScan.
  ///
  /// In en, this message translates to:
  /// **'Quick scan'**
  String get quickScan;

  /// No description provided for @createQr.
  ///
  /// In en, this message translates to:
  /// **'Create QR'**
  String get createQr;

  /// No description provided for @generateNew.
  ///
  /// In en, this message translates to:
  /// **'Generate new'**
  String get generateNew;

  /// No description provided for @myQrCodesTitle.
  ///
  /// In en, this message translates to:
  /// **'My QR Codes'**
  String get myQrCodesTitle;

  /// No description provided for @savedCodes.
  ///
  /// In en, this message translates to:
  /// **'Saved codes'**
  String get savedCodes;

  /// No description provided for @historyTitle.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get historyTitle;

  /// No description provided for @recentScans.
  ///
  /// In en, this message translates to:
  /// **'Recent scans'**
  String get recentScans;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @russian.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get russian;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeBold.
  ///
  /// In en, this message translates to:
  /// **'Scan, Create & Manage QR Codes Easily'**
  String get onboardingWelcomeBold;

  /// No description provided for @onboardingScanTitle.
  ///
  /// In en, this message translates to:
  /// **'Scan QR Codes'**
  String get onboardingScanTitle;

  /// No description provided for @onboardingScanBold.
  ///
  /// In en, this message translates to:
  /// **'Quickly Scan Any QR Code'**
  String get onboardingScanBold;

  /// No description provided for @onboardingScanRegular.
  ///
  /// In en, this message translates to:
  /// **'Align QR codes in frame and get instant\nresults'**
  String get onboardingScanRegular;

  /// No description provided for @onboardingCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'Create QR Codes'**
  String get onboardingCreateTitle;

  /// No description provided for @onboardingCreateBold.
  ///
  /// In en, this message translates to:
  /// **'Generate QR Codes Instantly'**
  String get onboardingCreateBold;

  /// No description provided for @onboardingCreateRegular.
  ///
  /// In en, this message translates to:
  /// **'Enter URL, text, or contact info and get\nyour custom QR'**
  String get onboardingCreateRegular;

  /// No description provided for @onboardingManageTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage & Share'**
  String get onboardingManageTitle;

  /// No description provided for @onboardingManageBold.
  ///
  /// In en, this message translates to:
  /// **'Save, Share, and Track All Your QR Codes'**
  String get onboardingManageBold;

  /// No description provided for @onboardingManageRegular.
  ///
  /// In en, this message translates to:
  /// **'Access My QR Codes and History anytime'**
  String get onboardingManageRegular;

  /// No description provided for @subscription.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscription;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get active;

  /// No description provided for @free.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get free;

  /// No description provided for @upgradeToPremium.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium'**
  String get upgradeToPremium;

  /// No description provided for @upgradeToPremiumToUnlock.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Premium to unlock all features'**
  String get upgradeToPremiumToUnlock;

  /// No description provided for @yourSubscriptionIsActive.
  ///
  /// In en, this message translates to:
  /// **'Your subscription is active'**
  String get yourSubscriptionIsActive;

  /// No description provided for @expiresNever.
  ///
  /// In en, this message translates to:
  /// **'Expires: Never'**
  String get expiresNever;

  /// No description provided for @editQrCode.
  ///
  /// In en, this message translates to:
  /// **'Edit QR Code'**
  String get editQrCode;

  /// No description provided for @scanSuccessful.
  ///
  /// In en, this message translates to:
  /// **'Scan Successful'**
  String get scanSuccessful;

  /// No description provided for @qrCodeDecodedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'QR code decoded successfully'**
  String get qrCodeDecodedSuccessfully;

  /// No description provided for @contentType.
  ///
  /// In en, this message translates to:
  /// **'Content Type'**
  String get contentType;

  /// No description provided for @designOptions.
  ///
  /// In en, this message translates to:
  /// **'Design Options'**
  String get designOptions;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @websiteUrl.
  ///
  /// In en, this message translates to:
  /// **'Website URL'**
  String get websiteUrl;

  /// No description provided for @fullContent.
  ///
  /// In en, this message translates to:
  /// **'Full Content'**
  String get fullContent;

  /// No description provided for @scanned.
  ///
  /// In en, this message translates to:
  /// **'Scanned'**
  String get scanned;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @scanResult.
  ///
  /// In en, this message translates to:
  /// **'Scan Result'**
  String get scanResult;

  /// No description provided for @noQrCodeData.
  ///
  /// In en, this message translates to:
  /// **'No QR code data'**
  String get noQrCodeData;

  /// No description provided for @goBack.
  ///
  /// In en, this message translates to:
  /// **'Go Back'**
  String get goBack;

  /// No description provided for @goToMyQrCodes.
  ///
  /// In en, this message translates to:
  /// **'Go to My QR Codes'**
  String get goToMyQrCodes;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @deleteQrCode.
  ///
  /// In en, this message translates to:
  /// **'Delete QR Code'**
  String get deleteQrCode;

  /// No description provided for @clearHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear History'**
  String get clearHistory;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @scannedCategory.
  ///
  /// In en, this message translates to:
  /// **'Scanned'**
  String get scannedCategory;

  /// No description provided for @createdCategory.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get createdCategory;

  /// No description provided for @urlCategory.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get urlCategory;

  /// No description provided for @textCategory.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get textCategory;

  /// No description provided for @wifiCategory.
  ///
  /// In en, this message translates to:
  /// **'WiFi'**
  String get wifiCategory;

  /// No description provided for @contactCategory.
  ///
  /// In en, this message translates to:
  /// **'Contact'**
  String get contactCategory;

  /// No description provided for @unlimitedQrScans.
  ///
  /// In en, this message translates to:
  /// **'Unlimited QR Scans'**
  String get unlimitedQrScans;

  /// No description provided for @scanAsManyQrCodesAsYouWant.
  ///
  /// In en, this message translates to:
  /// **'Scan as many QR codes as you want'**
  String get scanAsManyQrCodesAsYouWant;

  /// No description provided for @createAllQrTypes.
  ///
  /// In en, this message translates to:
  /// **'Create All QR Types'**
  String get createAllQrTypes;

  /// No description provided for @urlTextContactWifiAndMore.
  ///
  /// In en, this message translates to:
  /// **'URL, Text, Contact, WiFi, and more'**
  String get urlTextContactWifiAndMore;

  /// No description provided for @noAds.
  ///
  /// In en, this message translates to:
  /// **'No Ads'**
  String get noAds;

  /// No description provided for @cleanDistractionFreeExperience.
  ///
  /// In en, this message translates to:
  /// **'Clean, distraction-free experience'**
  String get cleanDistractionFreeExperience;

  /// No description provided for @cloudBackup.
  ///
  /// In en, this message translates to:
  /// **'Cloud Backup'**
  String get cloudBackup;

  /// No description provided for @syncAcrossAllYourDevices.
  ///
  /// In en, this message translates to:
  /// **'Sync across all your devices'**
  String get syncAcrossAllYourDevices;

  /// No description provided for @advancedAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Advanced Analytics'**
  String get advancedAnalytics;

  /// No description provided for @trackScansAndUsagePatterns.
  ///
  /// In en, this message translates to:
  /// **'Track scans and usage patterns'**
  String get trackScansAndUsagePatterns;

  /// No description provided for @recentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recentActivity;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @areYouSureYouWantToDeleteThisQrCode.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this QR code?'**
  String get areYouSureYouWantToDeleteThisQrCode;

  /// No description provided for @areYouSureYouWantToClearAllHistory.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to clear all history? This action cannot be undone.'**
  String get areYouSureYouWantToClearAllHistory;

  /// No description provided for @unlockFullQrTools.
  ///
  /// In en, this message translates to:
  /// **'Unlock Full QR\nTools'**
  String get unlockFullQrTools;

  /// No description provided for @unlimitedScansCustomQrCreationAndFullHistoryAccess.
  ///
  /// In en, this message translates to:
  /// **'Unlimited scans, custom QR creation, and full history access.'**
  String get unlimitedScansCustomQrCreationAndFullHistoryAccess;

  /// No description provided for @restore.
  ///
  /// In en, this message translates to:
  /// **'Restore'**
  String get restore;

  /// No description provided for @week.
  ///
  /// In en, this message translates to:
  /// **'week'**
  String get week;

  /// No description provided for @month.
  ///
  /// In en, this message translates to:
  /// **'month'**
  String get month;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'year'**
  String get year;

  /// No description provided for @threeDayFreeTrial.
  ///
  /// In en, this message translates to:
  /// **'3-day free trial'**
  String get threeDayFreeTrial;

  /// No description provided for @cancelAnytime.
  ///
  /// In en, this message translates to:
  /// **'Cancel anytime'**
  String get cancelAnytime;

  /// No description provided for @bestValueOption.
  ///
  /// In en, this message translates to:
  /// **'Best value option'**
  String get bestValueOption;

  /// No description provided for @mostPopular.
  ///
  /// In en, this message translates to:
  /// **'MOST POPULAR'**
  String get mostPopular;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @savePercent.
  ///
  /// In en, this message translates to:
  /// **'SAVE {percent}%'**
  String savePercent(String percent);

  /// No description provided for @alignQrCodeWithinFrame.
  ///
  /// In en, this message translates to:
  /// **'Align QR code within frame'**
  String get alignQrCodeWithinFrame;

  /// No description provided for @keepYourDeviceSteady.
  ///
  /// In en, this message translates to:
  /// **'Keep your device steady'**
  String get keepYourDeviceSteady;

  /// No description provided for @flash.
  ///
  /// In en, this message translates to:
  /// **'Flash'**
  String get flash;

  /// No description provided for @switchCamera.
  ///
  /// In en, this message translates to:
  /// **'Switch'**
  String get switchCamera;

  /// No description provided for @addLogo.
  ///
  /// In en, this message translates to:
  /// **'Add Logo'**
  String get addLogo;

  /// No description provided for @logoAdded.
  ///
  /// In en, this message translates to:
  /// **'Logo Added'**
  String get logoAdded;

  /// No description provided for @proFeature.
  ///
  /// In en, this message translates to:
  /// **'Pro Feature'**
  String get proFeature;

  /// No description provided for @updateQrCode.
  ///
  /// In en, this message translates to:
  /// **'Update QR Code'**
  String get updateQrCode;

  /// No description provided for @generateQrCode.
  ///
  /// In en, this message translates to:
  /// **'Generate QR Code'**
  String get generateQrCode;

  /// No description provided for @contactName.
  ///
  /// In en, this message translates to:
  /// **'Contact Name'**
  String get contactName;

  /// No description provided for @enterContactName.
  ///
  /// In en, this message translates to:
  /// **'Enter contact name...'**
  String get enterContactName;

  /// No description provided for @enterText.
  ///
  /// In en, this message translates to:
  /// **'Enter text...'**
  String get enterText;

  /// No description provided for @theQrCodeIsReady.
  ///
  /// In en, this message translates to:
  /// **'The QR code is ready'**
  String get theQrCodeIsReady;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @searchQrCodes.
  ///
  /// In en, this message translates to:
  /// **'Search QR codes...'**
  String get searchQrCodes;

  /// No description provided for @noQrCodesYet.
  ///
  /// In en, this message translates to:
  /// **'No QR codes yet'**
  String get noQrCodesYet;

  /// No description provided for @justNow.
  ///
  /// In en, this message translates to:
  /// **'Just now'**
  String get justNow;

  /// No description provided for @minuteAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} minute ago'**
  String minuteAgo(int count);

  /// No description provided for @minutesAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} minutes ago'**
  String minutesAgo(int count);

  /// No description provided for @hourAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} hour ago'**
  String hourAgo(int count);

  /// No description provided for @hoursAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} hours ago'**
  String hoursAgo(int count);

  /// No description provided for @dayAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} day ago'**
  String dayAgo(int count);

  /// No description provided for @daysAgo.
  ///
  /// In en, this message translates to:
  /// **'{count} days ago'**
  String daysAgo(int count);

  /// No description provided for @monthJan.
  ///
  /// In en, this message translates to:
  /// **'Jan'**
  String get monthJan;

  /// No description provided for @monthFeb.
  ///
  /// In en, this message translates to:
  /// **'Feb'**
  String get monthFeb;

  /// No description provided for @monthMar.
  ///
  /// In en, this message translates to:
  /// **'Mar'**
  String get monthMar;

  /// No description provided for @monthApr.
  ///
  /// In en, this message translates to:
  /// **'Apr'**
  String get monthApr;

  /// No description provided for @monthMay.
  ///
  /// In en, this message translates to:
  /// **'May'**
  String get monthMay;

  /// No description provided for @monthJun.
  ///
  /// In en, this message translates to:
  /// **'Jun'**
  String get monthJun;

  /// No description provided for @monthJul.
  ///
  /// In en, this message translates to:
  /// **'Jul'**
  String get monthJul;

  /// No description provided for @monthAug.
  ///
  /// In en, this message translates to:
  /// **'Aug'**
  String get monthAug;

  /// No description provided for @monthSep.
  ///
  /// In en, this message translates to:
  /// **'Sep'**
  String get monthSep;

  /// No description provided for @monthOct.
  ///
  /// In en, this message translates to:
  /// **'Oct'**
  String get monthOct;

  /// No description provided for @monthNov.
  ///
  /// In en, this message translates to:
  /// **'Nov'**
  String get monthNov;

  /// No description provided for @monthDec.
  ///
  /// In en, this message translates to:
  /// **'Dec'**
  String get monthDec;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
