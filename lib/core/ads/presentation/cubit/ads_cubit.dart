import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../domain/repositories/ads_repository.dart';
import '../../domain/usecases/can_show_ads_usecase.dart';
import '../../domain/usecases/init_ads_usecase.dart';
import '../../domain/usecases/load_interstitial_ad_usecase.dart';
import '../../domain/usecases/show_interstitial_ad_usecase.dart';
import '../../domain/usecases/load_rewarded_ad_usecase.dart';
import '../../domain/usecases/show_rewarded_ad_usecase.dart';
import '../../domain/usecases/load_app_open_ad_usecase.dart';
import '../../domain/usecases/show_app_open_ad_usecase.dart';
import 'ads_state.dart';

/// Cubit для управления состоянием рекламы.
class AdsCubit extends Cubit<AdsState> {
  final InitAdsUseCase _initAdsUseCase;
  final CanShowAdsUseCase _canShowAdsUseCase;
  final LoadInterstitialAdUseCase _loadInterstitialAdUseCase;
  final ShowInterstitialAdUseCase _showInterstitialAdUseCase;
  final LoadRewardedAdUseCase _loadRewardedAdUseCase;
  final ShowRewardedAdUseCase _showRewardedAdUseCase;
  final LoadAppOpenAdUseCase _loadAppOpenAdUseCase;
  final ShowAppOpenAdUseCase _showAppOpenAdUseCase;
  final AdsRepository _adsRepository;
  final Talker _talker;

  AdsCubit({
    required InitAdsUseCase initAdsUseCase,
    required CanShowAdsUseCase canShowAdsUseCase,
    required LoadInterstitialAdUseCase loadInterstitialAdUseCase,
    required ShowInterstitialAdUseCase showInterstitialAdUseCase,
    required LoadRewardedAdUseCase loadRewardedAdUseCase,
    required ShowRewardedAdUseCase showRewardedAdUseCase,
    required LoadAppOpenAdUseCase loadAppOpenAdUseCase,
    required ShowAppOpenAdUseCase showAppOpenAdUseCase,
    required AdsRepository adsRepository,
    required Talker talker,
  }) : _initAdsUseCase = initAdsUseCase,
       _canShowAdsUseCase = canShowAdsUseCase,
       _loadInterstitialAdUseCase = loadInterstitialAdUseCase,
       _showInterstitialAdUseCase = showInterstitialAdUseCase,
       _loadRewardedAdUseCase = loadRewardedAdUseCase,
       _showRewardedAdUseCase = showRewardedAdUseCase,
       _loadAppOpenAdUseCase = loadAppOpenAdUseCase,
       _showAppOpenAdUseCase = showAppOpenAdUseCase,
       _adsRepository = adsRepository,
       _talker = talker,
       super(const AdsInitial());

  /// Инициализирует AdMob SDK.
  Future<void> init() async {
    try {
      emit(const AdsLoading());
      await _initAdsUseCase();
      emit(const AdsLoaded());
      _talker.debug('AdsCubit: AdMob initialized');
    } catch (e, stackTrace) {
      _talker.error('AdsCubit: Failed to initialize AdMob', e, stackTrace);
      emit(AdsError(e.toString()));
    }
  }

  /// Проверяет, можно ли показывать рекламу.
  Future<bool> canShowAds() async {
    try {
      final canShow = await _canShowAdsUseCase();
      if (!canShow) {
        emit(const AdsDisabled());
      }
      return canShow;
    } catch (e, stackTrace) {
      _talker.error('AdsCubit: Failed to check if can show ads', e, stackTrace);
      return true; // В случае ошибки разрешаем показ
    }
  }

  /// Загружает межстраничную рекламу.
  Future<bool> loadInterstitialAd() async {
    try {
      final canShow = await canShowAds();
      if (!canShow) {
        return false;
      }

      emit(const AdsLoading());
      final loaded = await _loadInterstitialAdUseCase();
      if (loaded) {
        emit(const AdsLoaded());
        _talker.debug('AdsCubit: Interstitial ad loaded');
        return true;
      } else {
        emit(const AdsError('Failed to load interstitial ad'));
        return false;
      }
    } catch (e, stackTrace) {
      _talker.error('AdsCubit: Failed to load interstitial ad', e, stackTrace);
      emit(AdsError(e.toString()));
      return false;
    }
  }

  /// Показывает межстраничную рекламу.
  Future<void> showInterstitialAd() async {
    try {
      final canShow = await canShowAds();
      if (!canShow) {
        return;
      }

      // Если реклама не загружена, загружаем и ждем
      if (!_adsRepository.isInterstitialAdLoaded()) {
        _talker.debug('AdsCubit: Interstitial ad not loaded, loading...');
        final loaded = await loadInterstitialAd();
        if (!loaded) {
          _talker.warning('AdsCubit: Failed to load interstitial ad');
          return;
        }
        // Небольшая задержка для гарантии, что реклама готова
        await Future.delayed(const Duration(milliseconds: 100));
      }

      // Проверяем еще раз перед показом
      if (!_adsRepository.isInterstitialAdLoaded()) {
        _talker.warning(
          'AdsCubit: Interstitial ad still not loaded after load attempt',
        );
        return;
      }

      await _showInterstitialAdUseCase();
      _talker.debug('AdsCubit: Interstitial ad shown');
    } catch (e, stackTrace) {
      _talker.error('AdsCubit: Failed to show interstitial ad', e, stackTrace);
      emit(AdsError(e.toString()));
    }
  }

  /// Загружает вознаграждаемую рекламу.
  Future<void> loadRewardedAd() async {
    try {
      final canShow = await canShowAds();
      if (!canShow) {
        return;
      }

      emit(const AdsLoading());
      final loaded = await _loadRewardedAdUseCase();
      if (loaded) {
        emit(const AdsLoaded());
        _talker.debug('AdsCubit: Rewarded ad loaded');
      } else {
        emit(const AdsError('Failed to load rewarded ad'));
      }
    } catch (e, stackTrace) {
      _talker.error('AdsCubit: Failed to load rewarded ad', e, stackTrace);
      emit(AdsError(e.toString()));
    }
  }

  /// Показывает вознаграждаемую рекламу.
  Future<void> showRewardedAd({
    required Function(int amount, String type) onRewardEarned,
  }) async {
    try {
      final canShow = await canShowAds();
      if (!canShow) {
        return;
      }

      if (!_adsRepository.isRewardedAdLoaded()) {
        await loadRewardedAd();
      }

      await _showRewardedAdUseCase(onRewardEarned: onRewardEarned);
      _talker.debug('AdsCubit: Rewarded ad shown');
    } catch (e, stackTrace) {
      _talker.error('AdsCubit: Failed to show rewarded ad', e, stackTrace);
      emit(AdsError(e.toString()));
    }
  }

  /// Загружает App Open рекламу.
  Future<void> loadAppOpenAd() async {
    try {
      final canShow = await canShowAds();
      if (!canShow) {
        return;
      }

      emit(const AdsLoading());
      final loaded = await _loadAppOpenAdUseCase();
      if (loaded) {
        emit(const AdsLoaded());
        _talker.debug('AdsCubit: App open ad loaded');
      } else {
        emit(const AdsError('Failed to load app open ad'));
      }
    } catch (e, stackTrace) {
      _talker.error('AdsCubit: Failed to load app open ad', e, stackTrace);
      emit(AdsError(e.toString()));
    }
  }

  /// Показывает App Open рекламу.
  Future<void> showAppOpenAd() async {
    try {
      final canShow = await canShowAds();
      if (!canShow) {
        return;
      }

      if (!_adsRepository.isAppOpenAdLoaded()) {
        await loadAppOpenAd();
      }

      await _showAppOpenAdUseCase();
      _talker.debug('AdsCubit: App open ad shown');
    } catch (e, stackTrace) {
      _talker.error('AdsCubit: Failed to show app open ad', e, stackTrace);
      emit(AdsError(e.toString()));
    }
  }
}
