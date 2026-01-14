// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'QR Сканер';

  @override
  String get welcome => 'Добро пожаловать!';

  @override
  String welcomeWithName(String name) {
    return 'Добро пожаловать, $name!';
  }

  @override
  String get scanQrCode => 'Сканировать QR код';

  @override
  String get createQrCode => 'Создать QR код';

  @override
  String get myQrCodes => 'Мои QR коды';

  @override
  String get history => 'История';

  @override
  String get profile => 'Профиль';

  @override
  String get retry => 'Повторить';

  @override
  String get error => 'Ошибка';

  @override
  String get processing => 'Обработка...';

  @override
  String get continueText => 'Продолжить';

  @override
  String get termsOfService => 'Условия использования';

  @override
  String get privacyPolicy => 'Политика конфиденциальности';

  @override
  String get and => 'и';

  @override
  String get subscriptionPurchasedSuccessfully =>
      'Подписка успешно приобретена!';

  @override
  String get purchasesRestoredSuccessfully => 'Покупки успешно восстановлены!';

  @override
  String get noProductsAvailable =>
      'Продукты недоступны. Проверьте подключение к интернету и попробуйте снова.';

  @override
  String get noInternetConnection =>
      'Нет подключения к интернету. Проверьте сеть и попробуйте снова.';

  @override
  String get productsTemporarilyUnavailable =>
      'Продукты временно недоступны. Попробуйте позже.';

  @override
  String get failedToLoadProducts =>
      'Не удалось загрузить продукты. Проверьте подключение к интернету и попробуйте снова.';

  @override
  String get copiedToClipboard => 'Скопировано в буфер обмена';

  @override
  String get savedSuccessfully => 'Успешно сохранено';

  @override
  String get sharedSuccessfully => 'Успешно отправлено';

  @override
  String get noQrFoundInImage => 'QR код не найден в изображении';

  @override
  String get cannotOpenUrl => 'Не удалось открыть URL';

  @override
  String get simulatorNotSupported =>
      'Сканирование изображений недоступно на iOS симуляторе. Пожалуйста, используйте реальное устройство.';

  @override
  String get cameraUnavailable => 'Камера недоступна';

  @override
  String get cameraNotAvailableOnSimulator =>
      'Камера недоступна\nна iOS симуляторе';

  @override
  String get cameraAccessDenied => 'Доступ к камере запрещен';

  @override
  String get cameraPermissionDenied =>
      'Доступ к камере запрещен.\nВключите его в Настройках.';

  @override
  String get cameraPermissionRequired => 'Требуется разрешение камеры';

  @override
  String get cameraPermissionRequiredToScan =>
      'Требуется разрешение камеры\nдля сканирования QR кодов';

  @override
  String get initializingCamera => 'Инициализация камеры...';

  @override
  String get initializingCameraTitle => 'Инициализация камеры';

  @override
  String get cameraPermissionRequiredText => 'Требуется разрешение камеры';

  @override
  String get loadingCamera => 'Загрузка камеры...';

  @override
  String get useGalleryButtonToScan =>
      'Используйте кнопку Галерея для сканирования QR из фотографий';

  @override
  String get openSettings => 'Открыть настройки';

  @override
  String get requestPermission => 'Запросить разрешение';

  @override
  String get pleaseEnableCameraPermission =>
      'Пожалуйста, включите разрешение камеры\nв Настройках';

  @override
  String get restorePurchases => 'Восстановить покупки';

  @override
  String get autoRenewableCancelAnytime =>
      'Автоматическое продление. Отменить можно в любое время.';

  @override
  String get retryButton => 'Повторить';

  @override
  String get manageYourQrCodesEasily => 'Управляйте QR кодами легко';

  @override
  String get home => 'Главная';

  @override
  String get scan => 'Сканировать';

  @override
  String get scanQr => 'Сканировать QR';

  @override
  String get quickScan => 'Быстрое сканирование';

  @override
  String get createQr => 'Создать QR';

  @override
  String get generateNew => 'Создать новый';

  @override
  String get myQrCodesTitle => 'Мои QR коды';

  @override
  String get savedCodes => 'Сохраненные коды';

  @override
  String get historyTitle => 'История';

  @override
  String get recentScans => 'Недавние сканирования';

  @override
  String get language => 'Язык';

  @override
  String get english => 'Английский';

  @override
  String get russian => 'Русский';

  @override
  String get next => 'Далее';

  @override
  String get skip => 'Пропустить';

  @override
  String get getStarted => 'Начать';

  @override
  String get onboardingWelcomeTitle => 'Добро пожаловать';

  @override
  String get onboardingWelcomeBold =>
      'Сканируйте, создавайте и управляйте QR-кодами легко';

  @override
  String get onboardingScanTitle => 'Сканирование QR-кодов';

  @override
  String get onboardingScanBold => 'Быстро сканируйте любой QR-код';

  @override
  String get onboardingScanRegular =>
      'Наведите камеру на QR-код и получите\nмгновенный результат';

  @override
  String get onboardingCreateTitle => 'Создание QR-кодов';

  @override
  String get onboardingCreateBold => 'Генерируйте QR-коды мгновенно';

  @override
  String get onboardingCreateRegular =>
      'Введите URL, текст или контакт и получите\nсвой QR-код';

  @override
  String get onboardingManageTitle => 'Управление и обмен';

  @override
  String get onboardingManageBold =>
      'Сохраняйте, делитесь и отслеживайте все ваши QR-коды';

  @override
  String get onboardingManageRegular =>
      'Доступ к Моим QR-кодам и Истории в любое время';

  @override
  String get subscription => 'Подписка';

  @override
  String get active => 'Активна';

  @override
  String get free => 'Бесплатно';

  @override
  String get upgradeToPremium => 'Перейти на Premium';

  @override
  String get upgradeToPremiumToUnlock =>
      'Перейдите на Premium, чтобы разблокировать все функции';

  @override
  String get yourSubscriptionIsActive => 'Ваша подписка активна';

  @override
  String get expiresNever => 'Истекает: Никогда';

  @override
  String get editQrCode => 'Редактировать QR-код';

  @override
  String get scanSuccessful => 'Сканирование успешно';

  @override
  String get qrCodeDecodedSuccessfully => 'QR-код успешно расшифрован';

  @override
  String get contentType => 'Тип содержимого';

  @override
  String get designOptions => 'Параметры дизайна';

  @override
  String get color => 'Цвет';

  @override
  String get websiteUrl => 'URL веб-сайта';

  @override
  String get fullContent => 'Полное содержимое';

  @override
  String get scanned => 'Отсканировано';

  @override
  String get type => 'Тип';

  @override
  String get scanResult => 'Результат сканирования';

  @override
  String get noQrCodeData => 'Нет данных QR-кода';

  @override
  String get goBack => 'Назад';

  @override
  String get goToMyQrCodes => 'Перейти к Моим QR-кодам';

  @override
  String get gallery => 'Галерея';

  @override
  String get camera => 'Камера';

  @override
  String get deleteQrCode => 'Удалить QR-код';

  @override
  String get clearHistory => 'Очистить историю';

  @override
  String get all => 'Все';

  @override
  String get scannedCategory => 'Отсканированные';

  @override
  String get createdCategory => 'Созданные';

  @override
  String get urlCategory => 'URL';

  @override
  String get textCategory => 'Текст';

  @override
  String get wifiCategory => 'WiFi';

  @override
  String get contactCategory => 'Контакт';

  @override
  String get unlimitedQrScans => 'Неограниченное сканирование QR';

  @override
  String get scanAsManyQrCodesAsYouWant =>
      'Сканируйте столько QR-кодов, сколько хотите';

  @override
  String get createAllQrTypes => 'Создание всех типов QR';

  @override
  String get urlTextContactWifiAndMore =>
      'URL, Текст, Контакт, WiFi и многое другое';

  @override
  String get noAds => 'Без рекламы';

  @override
  String get cleanDistractionFreeExperience => 'Чистый опыт без отвлечений';

  @override
  String get cloudBackup => 'Облачное резервное копирование';

  @override
  String get syncAcrossAllYourDevices =>
      'Синхронизация на всех ваших устройствах';

  @override
  String get advancedAnalytics => 'Расширенная аналитика';

  @override
  String get trackScansAndUsagePatterns =>
      'Отслеживайте сканирования и модели использования';

  @override
  String get recentActivity => 'Недавняя активность';

  @override
  String get delete => 'Удалить';

  @override
  String get cancel => 'Отмена';

  @override
  String get clear => 'Очистить';

  @override
  String get areYouSureYouWantToDeleteThisQrCode =>
      'Вы уверены, что хотите удалить этот QR-код?';

  @override
  String get areYouSureYouWantToClearAllHistory =>
      'Вы уверены, что хотите очистить всю историю? Это действие нельзя отменить.';

  @override
  String get unlockFullQrTools => 'Разблокируйте полный\nнабор QR-инструментов';

  @override
  String get unlimitedScansCustomQrCreationAndFullHistoryAccess =>
      'Неограниченное сканирование, создание QR-кодов и полный доступ к истории.';

  @override
  String get restore => 'Восстановить';

  @override
  String get week => 'неделя';

  @override
  String get month => 'месяц';

  @override
  String get year => 'год';

  @override
  String get threeDayFreeTrial => '3-дневный бесплатный период';

  @override
  String get cancelAnytime => 'Отмена в любое время';

  @override
  String get bestValueOption => 'Лучшее предложение';

  @override
  String get mostPopular => 'ПОПУЛЯРНО';

  @override
  String get save => 'Сохранить';

  @override
  String savePercent(String percent) {
    return 'ЭКОНОМИЯ $percent%';
  }

  @override
  String get alignQrCodeWithinFrame => 'Выровняйте QR-код в рамке';

  @override
  String get keepYourDeviceSteady => 'Держите устройство неподвижно';

  @override
  String get flash => 'Вспышка';

  @override
  String get switchCamera => 'Переключить';

  @override
  String get addLogo => 'Добавить логотип';

  @override
  String get logoAdded => 'Логотип добавлен';

  @override
  String get proFeature => 'Pro функция';

  @override
  String get updateQrCode => 'Обновить QR-код';

  @override
  String get generateQrCode => 'Создать QR-код';

  @override
  String get contactName => 'Имя контакта';

  @override
  String get enterContactName => 'Введите имя контакта...';

  @override
  String get enterText => 'Введите текст...';

  @override
  String get theQrCodeIsReady => 'QR-код готов';

  @override
  String get share => 'Поделиться';

  @override
  String get searchQrCodes => 'Поиск QR-кодов...';

  @override
  String get noQrCodesYet => 'QR-кодов пока нет';

  @override
  String get justNow => 'Только что';

  @override
  String minuteAgo(int count) {
    return '$count минуту назад';
  }

  @override
  String minutesAgo(int count) {
    return '$count минут назад';
  }

  @override
  String hourAgo(int count) {
    return '$count час назад';
  }

  @override
  String hoursAgo(int count) {
    return '$count часов назад';
  }

  @override
  String dayAgo(int count) {
    return '$count день назад';
  }

  @override
  String daysAgo(int count) {
    return '$count дней назад';
  }

  @override
  String get monthJan => 'Янв';

  @override
  String get monthFeb => 'Фев';

  @override
  String get monthMar => 'Мар';

  @override
  String get monthApr => 'Апр';

  @override
  String get monthMay => 'Май';

  @override
  String get monthJun => 'Июн';

  @override
  String get monthJul => 'Июл';

  @override
  String get monthAug => 'Авг';

  @override
  String get monthSep => 'Сен';

  @override
  String get monthOct => 'Окт';

  @override
  String get monthNov => 'Ноя';

  @override
  String get monthDec => 'Дек';
}
