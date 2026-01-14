import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../subscription/apphud_service.dart';
import 'att_service.dart';
import 'att_status.dart';

/// Сервис для работы с AppsFlyer.
///
/// Инкапсулирует работу с AppsFlyer SDK, скрывая детали реализации.
class AppsFlyerService {
  final Talker _talker;
  final AttService _attService;
  AppHudService? _appHudService;
  static const String _devKey = 'GAgckFyN4yETigBtP4qtRG';
  static const String _appleAppId = '6749377146';
  AppsflyerSdk? _appsflyerSdk;
  bool _isInitialized = false;

  AppsFlyerService({
    required Talker talker,
    required AttService attService,
    AppHudService? appHudService,
  })  : _talker = talker,
        _attService = attService,
        _appHudService = appHudService;

  /// Устанавливает AppHudService для передачи атрибуции.
  void setAppHudService(AppHudService appHudService) {
    _appHudService = appHudService;
  }

  /// Инициализирует AppsFlyer.
  Future<void> init() async {
    if (_isInitialized) {
      _talker.debug('AppsFlyer already initialized');
      return;
    }

    try {
      final appsFlyerOptions = AppsFlyerOptions(
        afDevKey: _devKey,
        appId: _appleAppId,
        showDebug: true,
      );

      _appsflyerSdk = AppsflyerSdk(appsFlyerOptions);
      await _appsflyerSdk!.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true,
      );

      _setupCallbacks();
      _isInitialized = true;
      _talker.debug('AppsFlyer initialized');

      // Устанавливаем user ID только если ATT разрешен
      try {
        final attStatus = await _attService.getStatus();
        if (attStatus == AttStatus.authorized && _appsflyerSdk != null) {
          _talker.debug('AppsFlyer: ATT authorized, user tracking enabled');
        }
      } catch (e) {
        _talker.warning('AppsFlyer: Failed to check ATT status: $e');
      }
    } catch (e, stackTrace) {
      _talker.error('AppsFlyer: Failed to initialize', e, stackTrace);
    }
  }

  /// Настраивает колбэки AppsFlyer.
  void _setupCallbacks() {
    _appsflyerSdk?.onInstallConversionData((data) {
      _talker.debug('AppsFlyer: Conversion data received: $data');
      
      // Передаем данные конверсии в AppHud
      if (_appHudService != null && data != null) {
        final attributionData = <String, String>{};
        
        // Извлекаем ключевые данные из conversion data
        if (data is Map) {
          final mediaSource = data['media_source']?.toString();
          final campaign = data['campaign']?.toString();
          final afStatus = data['af_status']?.toString();
          final isFirstLaunch = data['is_first_launch']?.toString();
          
          // Проверяем Apple Search Ads данные
          final isSearchAds = data['is_search_ads']?.toString() == 'true' ||
              mediaSource?.toLowerCase().contains('searchads') == true;
          
          if (mediaSource != null) {
            attributionData['media_source'] = mediaSource;
          }
          if (campaign != null) {
            attributionData['campaign'] = campaign;
          }
          if (afStatus != null) {
            attributionData['af_status'] = afStatus;
          }
          if (isFirstLaunch != null) {
            attributionData['is_first_launch'] = isFirstLaunch;
          }
          if (isSearchAds) {
            attributionData['is_apple_search_ads'] = 'true';
            _talker.debug('AppsFlyer: Apple Search Ads detected');
          }
          
          // Добавляем ATT статус
          _attService.getStatus().then((attStatus) {
            attributionData['att_status'] = attStatus.toString().split('.').last;
            attributionData['source'] = 'appsflyer';
            
            _appHudService!.setAttribution(attributionData);
            _talker.debug('AppsFlyer: Attribution data sent to AppHud: $attributionData');
          });
        }
      }
    });

    _appsflyerSdk?.onAppOpenAttribution((data) {
      _talker.debug('AppsFlyer: App open attribution: $data');
    });

    _appsflyerSdk?.onDeepLinking((data) {
      _talker.debug('AppsFlyer: Deep linking: $data');
    });
  }

  /// Получает данные атрибуции для передачи в AppHud.
  Future<Map<String, String>> getAttributionData() async {
    try {
      final attStatus = await _attService.getStatus();
      final attStatusString = attStatus.toString().split('.').last;

      return {'att_status': attStatusString, 'source': 'appsflyer'};
    } catch (e, stackTrace) {
      _talker.error('Failed to get attribution data', e, stackTrace);
      return {};
    }
  }

  /// Логирует событие в AppsFlyer.
  Future<void> logEvent(
    String eventName,
    Map<String, Object> parameters,
  ) async {
    try {
      if (!_isInitialized || _appsflyerSdk == null) {
        _talker.warning(
          'AppsFlyer not initialized, skipping event: $eventName',
        );
        return;
      }

      _appsflyerSdk!.logEvent(eventName, parameters);
      _talker.debug(
        'AppsFlyer event logged: $eventName with params: $parameters',
      );
    } catch (e, stackTrace) {
      _talker.error('Failed to log AppsFlyer event: $eventName', e, stackTrace);
    }
  }

  /// Устанавливает пользовательские данные.
  Future<void> setUserData(Map<String, String> data) async {
    try {
      if (!_isInitialized || _appsflyerSdk == null) {
        return;
      }

      for (final entry in data.entries) {
        _appsflyerSdk!.setAdditionalData({entry.key: entry.value});
      }
      _talker.debug('AppsFlyer user data set: $data');
    } catch (e, stackTrace) {
      _talker.error('Failed to set AppsFlyer user data', e, stackTrace);
    }
  }
}
