import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../constants/admob_constants.dart';

/// Completer для ожидания загрузки рекламы
class _AdLoadCompleter {
  final Completer<bool> _completer = Completer<bool>();
  bool _isCompleted = false;

  void complete(bool success) {
    if (!_isCompleted) {
      _isCompleted = true;
      _completer.complete(success);
    }
  }

  Future<bool> get future => _completer.future;
}

/// Data source для работы с AdMob SDK.
///
/// Инкапсулирует прямую работу с google_mobile_ads пакетом.
class AdMobDataSource {
  final Talker _talker;

  BannerAd? _bannerAd;
  InterstitialAd? _interstitialAd;
  RewardedAd? _rewardedAd;
  AppOpenAd? _appOpenAd;

  bool _isInterstitialAdLoaded = false;
  bool _isRewardedAdLoaded = false;
  bool _isAppOpenAdLoaded = false;

  AdMobDataSource({required Talker talker}) : _talker = talker;

  /// Инициализирует AdMob SDK.
  Future<void> init() async {
    try {
      _talker.debug('AdMob: Initializing SDK');
      await MobileAds.instance.initialize();
      _talker.debug('AdMob: SDK initialized successfully');
    } catch (e, stackTrace) {
      _talker.error('AdMob: Failed to initialize SDK', e, stackTrace);
      rethrow;
    }
  }

  /// Создает AdRequest с тестовыми настройками для разработки.
  AdRequest _createAdRequest() {
    if (kDebugMode) {
      // В debug режиме используем тестовые настройки
      return const AdRequest();
    } else {
      // В release режиме используем обычный запрос
      return const AdRequest();
    }
  }

  /// Загружает баннерную рекламу.
  ///
  /// Возвращает загруженный BannerAd или null в случае ошибки.
  Future<BannerAd?> loadBannerAd({
    required Function(BannerAd ad) onAdLoaded,
    required Function(LoadAdError error) onAdFailedToLoad,
  }) async {
    try {
      _talker.debug('AdMob: Loading banner ad');

      final bannerAd = BannerAd(
        adUnitId: AdMobConstants.bannerAdUnitId,
        size: AdSize.banner,
        request: _createAdRequest(),
        listener: BannerAdListener(
          onAdLoaded: (ad) {
            _talker.debug('AdMob: Banner ad loaded');
            onAdLoaded(ad as BannerAd);
          },
          onAdFailedToLoad: (ad, error) {
            _talker.warning(
              'AdMob: Banner ad failed to load: ${error.code} - ${error.message}',
            );
            // Логируем device ID для тестирования
            if (kDebugMode && error.code == 1) {
              _talker.debug(
                'AdMob: Error code 1 (No ad to show) - This may indicate that test ads are not available. '
                'Check AdMob console or add your device ID to test devices.',
              );
            }
            ad.dispose();
            onAdFailedToLoad(error);
          },
        ),
      );

      await bannerAd.load();
      _bannerAd = bannerAd;
      return bannerAd;
    } catch (e, stackTrace) {
      _talker.error('AdMob: Failed to load banner ad', e, stackTrace);
      return null;
    }
  }

  _AdLoadCompleter? _interstitialLoadCompleter;

  /// Загружает межстраничную рекламу.
  Future<bool> loadInterstitialAd() async {
    try {
      _talker.debug('AdMob: Loading interstitial ad');

      // Если уже загружается, ждем завершения
      if (_interstitialLoadCompleter != null) {
        _talker.debug('AdMob: Interstitial ad already loading, waiting...');
        return await _interstitialLoadCompleter!.future;
      }

      // Если уже загружена, возвращаем true
      if (_isInterstitialAdLoaded && _interstitialAd != null) {
        _talker.debug('AdMob: Interstitial ad already loaded');
        return true;
      }

      _interstitialLoadCompleter = _AdLoadCompleter();

      await InterstitialAd.load(
        adUnitId: AdMobConstants.interstitialAdUnitId,
        request: _createAdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            _talker.debug('AdMob: Interstitial ad loaded');
            _interstitialAd = ad;
            _isInterstitialAdLoaded = true;
            _interstitialLoadCompleter?.complete(true);
            _interstitialLoadCompleter = null;

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                _talker.debug('AdMob: Interstitial ad dismissed');
                ad.dispose();
                _isInterstitialAdLoaded = false;
                _interstitialAd = null;
                // Автоматически загружаем следующую рекламу
                loadInterstitialAd();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                _talker.warning(
                  'AdMob: Interstitial ad failed to show: ${error.message}',
                );
                ad.dispose();
                _isInterstitialAdLoaded = false;
                _interstitialAd = null;
                loadInterstitialAd();
              },
            );
          },
          onAdFailedToLoad: (error) {
            _talker.warning(
              'AdMob: Interstitial ad failed to load: ${error.message}',
            );
            _isInterstitialAdLoaded = false;
            _interstitialLoadCompleter?.complete(false);
            _interstitialLoadCompleter = null;
          },
        ),
      );

      // Ждем загрузки с таймаутом 30 секунд (для эмуляторов с медленным интернетом)
      return await _interstitialLoadCompleter!.future.timeout(
        const Duration(seconds: 30),
        onTimeout: () {
          _talker.warning('AdMob: Interstitial ad load timeout after 30 seconds');
          _interstitialLoadCompleter = null;
          return false;
        },
      );
    } catch (e, stackTrace) {
      _talker.error('AdMob: Failed to load interstitial ad', e, stackTrace);
      _isInterstitialAdLoaded = false;
      _interstitialLoadCompleter?.complete(false);
      _interstitialLoadCompleter = null;
      return false;
    }
  }

  /// Показывает межстраничную рекламу.
  Future<void> showInterstitialAd() async {
    if (_interstitialAd != null && _isInterstitialAdLoaded) {
      _talker.debug('AdMob: Showing interstitial ad');
      await _interstitialAd!.show();
    } else {
      _talker.warning('AdMob: Interstitial ad is not loaded');
      throw Exception('Interstitial ad is not loaded');
    }
  }

  /// Загружает вознаграждаемую рекламу.
  Future<bool> loadRewardedAd() async {
    try {
      _talker.debug('AdMob: Loading rewarded ad');

      await RewardedAd.load(
        adUnitId: AdMobConstants.rewardedAdUnitId,
        request: _createAdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (ad) {
            _talker.debug('AdMob: Rewarded ad loaded');
            _rewardedAd = ad;
            _isRewardedAdLoaded = true;

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                _talker.debug('AdMob: Rewarded ad dismissed');
                ad.dispose();
                _isRewardedAdLoaded = false;
                _rewardedAd = null;
                loadRewardedAd();
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                _talker.warning(
                  'AdMob: Rewarded ad failed to show: ${error.message}',
                );
                ad.dispose();
                _isRewardedAdLoaded = false;
                _rewardedAd = null;
                loadRewardedAd();
              },
            );
          },
          onAdFailedToLoad: (error) {
            _talker.warning(
              'AdMob: Rewarded ad failed to load: ${error.message}',
            );
            _isRewardedAdLoaded = false;
          },
        ),
      );

      return true;
    } catch (e, stackTrace) {
      _talker.error('AdMob: Failed to load rewarded ad', e, stackTrace);
      _isRewardedAdLoaded = false;
      return false;
    }
  }

  /// Показывает вознаграждаемую рекламу.
  Future<void> showRewardedAd({
    required Function(int amount, String type) onRewardEarned,
  }) async {
    if (_rewardedAd != null && _isRewardedAdLoaded) {
      _talker.debug('AdMob: Showing rewarded ad');
      await _rewardedAd!.show(
        onUserEarnedReward: (ad, reward) {
          _talker.debug(
            'AdMob: User earned reward: ${reward.amount} ${reward.type}',
          );
          onRewardEarned(reward.amount.toInt(), reward.type);
        },
      );
    } else {
      _talker.warning('AdMob: Rewarded ad is not loaded');
      throw Exception('Rewarded ad is not loaded');
    }
  }

  /// Загружает App Open рекламу.
  Future<bool> loadAppOpenAd() async {
    try {
      _talker.debug('AdMob: Loading app open ad');

      await AppOpenAd.load(
        adUnitId: AdMobConstants.appOpenAdUnitId,
        request: _createAdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(
          onAdLoaded: (ad) {
            _talker.debug('AdMob: App open ad loaded');
            _appOpenAd = ad;
            _isAppOpenAdLoaded = true;

            ad.fullScreenContentCallback = FullScreenContentCallback(
              onAdDismissedFullScreenContent: (ad) {
                _talker.debug('AdMob: App open ad dismissed');
                ad.dispose();
                _isAppOpenAdLoaded = false;
                _appOpenAd = null;
              },
              onAdFailedToShowFullScreenContent: (ad, error) {
                _talker.warning(
                  'AdMob: App open ad failed to show: ${error.message}',
                );
                ad.dispose();
                _isAppOpenAdLoaded = false;
                _appOpenAd = null;
              },
            );
          },
          onAdFailedToLoad: (error) {
            _talker.warning(
              'AdMob: App open ad failed to load: ${error.message}',
            );
            _isAppOpenAdLoaded = false;
          },
        ),
      );

      return true;
    } catch (e, stackTrace) {
      _talker.error('AdMob: Failed to load app open ad', e, stackTrace);
      _isAppOpenAdLoaded = false;
      return false;
    }
  }

  /// Показывает App Open рекламу.
  Future<void> showAppOpenAd() async {
    if (_appOpenAd != null && _isAppOpenAdLoaded) {
      _talker.debug('AdMob: Showing app open ad');
      await _appOpenAd!.show();
    } else {
      _talker.warning('AdMob: App open ad is not loaded');
      throw Exception('App open ad is not loaded');
    }
  }

  /// Проверяет, загружена ли межстраничная реклама.
  bool isInterstitialAdLoaded() => _isInterstitialAdLoaded;

  /// Проверяет, загружена ли вознаграждаемая реклама.
  bool isRewardedAdLoaded() => _isRewardedAdLoaded;

  /// Проверяет, загружена ли App Open реклама.
  bool isAppOpenAdLoaded() => _isAppOpenAdLoaded;

  /// Освобождает ресурсы.
  void dispose() {
    _bannerAd?.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    _appOpenAd?.dispose();
  }
}
