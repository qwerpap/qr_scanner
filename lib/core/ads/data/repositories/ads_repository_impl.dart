import 'package:talker_flutter/talker_flutter.dart';
import '../../domain/repositories/ads_repository.dart';
import '../../../subscription/apphud_service.dart';
import '../datasources/admob_datasource.dart';

/// Реализация репозитория для работы с рекламой.
class AdsRepositoryImpl implements AdsRepository {
  final AdMobDataSource _dataSource;
  final AppHudService _appHudService;
  final Talker _talker;

  AdsRepositoryImpl({
    required AdMobDataSource dataSource,
    required AppHudService appHudService,
    required Talker talker,
  }) : _dataSource = dataSource,
       _appHudService = appHudService,
       _talker = talker;

  @override
  Future<void> init() async {
    try {
      _talker.debug('AdsRepository: Initializing');
      await _dataSource.init();
      _talker.debug('AdsRepository: Initialized successfully');
    } catch (e, stackTrace) {
      _talker.error('AdsRepository: Failed to initialize', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<bool> canShowAds() async {
    try {
      // Проверяем статус подписки
      final isPremium = await _appHudService.isPremium();
      if (isPremium) {
        _talker.debug(
          'AdsRepository: User has premium subscription, ads disabled',
        );
        return false;
      }

      _talker.debug('AdsRepository: User can see ads');
      return true;
    } catch (e, stackTrace) {
      _talker.error(
        'AdsRepository: Failed to check if can show ads',
        e,
        stackTrace,
      );
      // В случае ошибки проверки подписки, разрешаем показ рекламы
      return true;
    }
  }

  @override
  Future<bool> loadBannerAd() async {
    try {
      _talker.debug('AdsRepository: Loading banner ad');
      // Баннер загружается через виджет, поэтому здесь просто возвращаем true
      return true;
    } catch (e, stackTrace) {
      _talker.error('AdsRepository: Failed to load banner ad', e, stackTrace);
      return false;
    }
  }

  @override
  Future<bool> loadInterstitialAd() async {
    try {
      _talker.debug('AdsRepository: Loading interstitial ad');
      final canShow = await canShowAds();
      if (!canShow) {
        _talker.debug('AdsRepository: Cannot show ads, skipping load');
        return false;
      }
      return await _dataSource.loadInterstitialAd();
    } catch (e, stackTrace) {
      _talker.error(
        'AdsRepository: Failed to load interstitial ad',
        e,
        stackTrace,
      );
      return false;
    }
  }

  @override
  Future<void> showInterstitialAd() async {
    try {
      _talker.debug('AdsRepository: Showing interstitial ad');
      final canShow = await canShowAds();
      if (!canShow) {
        _talker.debug('AdsRepository: Cannot show ads, user has premium');
        return;
      }
      await _dataSource.showInterstitialAd();
    } catch (e, stackTrace) {
      _talker.error(
        'AdsRepository: Failed to show interstitial ad',
        e,
        stackTrace,
      );
      rethrow;
    }
  }

  @override
  Future<bool> loadRewardedAd() async {
    try {
      _talker.debug('AdsRepository: Loading rewarded ad');
      final canShow = await canShowAds();
      if (!canShow) {
        _talker.debug('AdsRepository: Cannot show ads, skipping load');
        return false;
      }
      return await _dataSource.loadRewardedAd();
    } catch (e, stackTrace) {
      _talker.error('AdsRepository: Failed to load rewarded ad', e, stackTrace);
      return false;
    }
  }

  @override
  Future<void> showRewardedAd({
    required Function(int amount, String type) onRewardEarned,
  }) async {
    try {
      _talker.debug('AdsRepository: Showing rewarded ad');
      final canShow = await canShowAds();
      if (!canShow) {
        _talker.debug('AdsRepository: Cannot show ads, user has premium');
        return;
      }
      await _dataSource.showRewardedAd(onRewardEarned: onRewardEarned);
    } catch (e, stackTrace) {
      _talker.error('AdsRepository: Failed to show rewarded ad', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<bool> loadAppOpenAd() async {
    try {
      _talker.debug('AdsRepository: Loading app open ad');
      final canShow = await canShowAds();
      if (!canShow) {
        _talker.debug('AdsRepository: Cannot show ads, skipping load');
        return false;
      }
      return await _dataSource.loadAppOpenAd();
    } catch (e, stackTrace) {
      _talker.error('AdsRepository: Failed to load app open ad', e, stackTrace);
      return false;
    }
  }

  @override
  Future<void> showAppOpenAd() async {
    try {
      _talker.debug('AdsRepository: Showing app open ad');
      final canShow = await canShowAds();
      if (!canShow) {
        _talker.debug('AdsRepository: Cannot show ads, user has premium');
        return;
      }
      await _dataSource.showAppOpenAd();
    } catch (e, stackTrace) {
      _talker.error('AdsRepository: Failed to show app open ad', e, stackTrace);
      rethrow;
    }
  }

  @override
  bool isInterstitialAdLoaded() => _dataSource.isInterstitialAdLoaded();

  @override
  bool isRewardedAdLoaded() => _dataSource.isRewardedAdLoaded();

  @override
  bool isAppOpenAdLoaded() => _dataSource.isAppOpenAdLoaded();
}
