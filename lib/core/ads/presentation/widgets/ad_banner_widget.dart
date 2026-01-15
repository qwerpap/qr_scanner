import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';
import '../../../constants/admob_constants.dart';

/// Виджет для отображения баннерной рекламы.
///
/// Автоматически загружает и отображает баннерную рекламу.
/// Скрывается, если реклама не загружена или пользователь имеет подписку.
class AdBannerWidget extends StatefulWidget {
  final Future<bool> Function() canShowAds;

  const AdBannerWidget({super.key, required this.canShowAds});

  @override
  State<AdBannerWidget> createState() => _AdBannerWidgetState();
}

class _AdBannerWidgetState extends State<AdBannerWidget> {
  BannerAd? _bannerAd;
  bool _isAdLoaded = false;
  bool _canShowAds = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      debugPrint('AdBannerWidget: initState called');
    }
    // Задержка для инициализации AdMob SDK
    // AdMob инициализируется в main.dart, но может потребоваться время
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        if (kDebugMode) {
          debugPrint('AdBannerWidget: Delayed callback executed, calling _checkCanShowAds');
        }
        _checkCanShowAds();
      } else {
        if (kDebugMode) {
          debugPrint('AdBannerWidget: Widget not mounted, skipping _checkCanShowAds');
        }
      }
    });
  }

  Future<void> _checkCanShowAds() async {
    if (kDebugMode) {
      debugPrint('AdBannerWidget: Checking if can show ads...');
    }
    
    final canShow = await widget.canShowAds();
    if (!mounted) return;

    if (kDebugMode) {
      debugPrint('AdBannerWidget: Can show ads: $canShow');
    }

    setState(() {
      _canShowAds = canShow;
    });

    if (_canShowAds && !_isLoading) {
      if (kDebugMode) {
        debugPrint('AdBannerWidget: Starting to load banner ad...');
      }
      _loadBannerAd();
    } else {
      if (kDebugMode) {
        debugPrint('AdBannerWidget: Not loading ad - canShow: $_canShowAds, isLoading: $_isLoading');
      }
    }
  }

  Future<void> _loadBannerAd() async {
    if (_isLoading) return;

    setState(() {
      _isLoading = true;
    });

    if (kDebugMode) {
      debugPrint(
        'AdBannerWidget: Loading banner ad with ID: ${AdMobConstants.bannerAdUnitId}',
      );
    }

    // Проверяем, что AdMob инициализирован
    try {
      await MobileAds.instance.initialize();
      if (kDebugMode) {
        debugPrint('AdBannerWidget: AdMob initialized');
      }
    } catch (e) {
      if (kDebugMode) {
        debugPrint('AdBannerWidget: AdMob already initialized or error: $e');
      }
    }

    if (kDebugMode) {
      debugPrint('AdBannerWidget: Creating BannerAd instance...');
    }

    final bannerAd = BannerAd(
      adUnitId: AdMobConstants.bannerAdUnitId,
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          if (kDebugMode) {
            debugPrint('AdBannerWidget: ✅ Banner ad loaded successfully!');
          }
          if (!mounted) {
            if (kDebugMode) {
              debugPrint('AdBannerWidget: Widget not mounted, disposing ad');
            }
            ad.dispose();
            return;
          }
          setState(() {
            _isAdLoaded = true;
            _isLoading = false;
          });
          if (kDebugMode) {
            debugPrint('AdBannerWidget: State updated - ad is loaded and ready to show');
          }
        },
        onAdFailedToLoad: (ad, error) {
          if (kDebugMode) {
            debugPrint(
              'AdBannerWidget: ❌ Banner ad failed to load: ${error.code} - ${error.message}',
            );
            debugPrint(
              'AdBannerWidget: Domain: ${error.domain}, ResponseInfo: ${error.responseInfo}',
            );
          }
          ad.dispose();
          if (mounted) {
            setState(() {
              _isAdLoaded = false;
              _isLoading = false;
            });
          }
          // Повторная попытка через 10 секунд (увеличено для эмулятора)
          Future.delayed(const Duration(seconds: 10), () {
            if (mounted && _canShowAds && !_isAdLoaded) {
              if (kDebugMode) {
                debugPrint('AdBannerWidget: Retrying to load banner ad...');
              }
              _loadBannerAd();
            }
          });
        },
        onAdOpened: (_) {
          if (kDebugMode) {
            debugPrint('AdBannerWidget: Banner ad opened');
          }
        },
        onAdClosed: (_) {
          if (kDebugMode) {
            debugPrint('AdBannerWidget: Banner ad closed');
          }
        },
        onAdImpression: (_) {
          if (kDebugMode) {
            debugPrint('AdBannerWidget: Banner ad impression recorded');
          }
        },
      ),
    );

    _bannerAd = bannerAd;
    
    if (kDebugMode) {
      debugPrint('AdBannerWidget: Calling bannerAd.load()...');
    }
    
    bannerAd.load();
    
    if (kDebugMode) {
      debugPrint('AdBannerWidget: bannerAd.load() called, waiting for callback...');
    }
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Показываем индикатор загрузки во время загрузки рекламы
    if (_isLoading) {
      return const SizedBox(
        height: 50,
        child: Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
      );
    }

    // Скрываем если не можем показывать рекламу или не загружена
    if (!_canShowAds || !_isAdLoaded || _bannerAd == null) {
      return const SizedBox.shrink();
    }

    return Container(
      alignment: Alignment.center,
      width: double.infinity,
      height: _bannerAd!.size.height.toDouble(),
      color: Colors.transparent,
      child: AdWidget(ad: _bannerAd!),
    );
  }
}
