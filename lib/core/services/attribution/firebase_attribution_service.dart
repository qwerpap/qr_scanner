import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../subscription/apphud_service.dart';

/// Сервис для получения данных атрибуции из Firebase и передачи в AppHud.
class FirebaseAttributionService {
  final FirebaseAnalytics _analytics;
  final Talker _talker;
  AppHudService? _appHudService;

  FirebaseAttributionService({
    required FirebaseAnalytics analytics,
    required Talker talker,
  })  : _analytics = analytics,
        _talker = talker;

  /// Устанавливает AppHudService для передачи атрибуции.
  void setAppHudService(AppHudService appHudService) {
    _appHudService = appHudService;
  }

  /// Получает данные атрибуции из Firebase и передает в AppHud.
  Future<void> sendAttributionToAppHud() async {
    try {
      if (_appHudService == null) {
        _talker.warning('FirebaseAttribution: AppHudService not set');
        return;
      }

      // Firebase Analytics автоматически собирает данные атрибуции
      // Получаем app instance ID для идентификации установки
      final appInstanceId = await _analytics.appInstanceId;
      
      final attributionData = <String, String>{
        'source': 'firebase',
      };

      if (appInstanceId != null && appInstanceId.isNotEmpty) {
        attributionData['firebase_app_instance_id'] = appInstanceId;
      }

      if (_appHudService != null) {
        await _appHudService!.setAttribution(attributionData);
        _talker.debug('FirebaseAttribution: Attribution data sent to AppHud: $attributionData');
      }
    } catch (e, stackTrace) {
      _talker.error('FirebaseAttribution: Failed to send attribution', e, stackTrace);
    }
  }

  /// Логирует событие в Firebase Analytics.
  Future<void> logEvent(String eventName, Map<String, Object> parameters) async {
    try {
      final filteredParams = <String, Object>{};
      for (final entry in parameters.entries) {
        // Firebase Analytics принимает только String или num
        // Конвертируем bool в int (0 или 1)
        final value = entry.value;
        if (value is bool) {
          filteredParams[entry.key] = value ? 1 : 0;
        } else {
          filteredParams[entry.key] = value;
        }
      }

      await _analytics.logEvent(
        name: eventName,
        parameters: filteredParams.isEmpty ? null : filteredParams,
      );
      _talker.debug('FirebaseAnalytics: Event logged: $eventName with params: $filteredParams');
    } catch (e, stackTrace) {
      _talker.error('FirebaseAnalytics: Failed to log event: $eventName', e, stackTrace);
    }
  }
}
