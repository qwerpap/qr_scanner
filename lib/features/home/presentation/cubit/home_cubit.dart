import 'package:qr_scanner/l10n/app_localizations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../../core/bloc/bloc_providers.dart';
import '../../data/mappers/qr_code_to_recent_activity_mapper.dart';
import '../../domain/usecases/get_recent_activities_usecase.dart';
import '../../domain/usecases/get_saved_qr_codes_count_usecase.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final GetRecentActivitiesUseCase _getRecentActivitiesUseCase;
  final GetSavedQrCodesCountUseCase _getSavedQrCodesCountUseCase;
  final Talker _talker = getIt<Talker>();

  HomeCubit({
    required GetRecentActivitiesUseCase getRecentActivitiesUseCase,
    required GetSavedQrCodesCountUseCase getSavedQrCodesCountUseCase,
  }) : _getRecentActivitiesUseCase = getRecentActivitiesUseCase,
       _getSavedQrCodesCountUseCase = getSavedQrCodesCountUseCase,
       super(const HomeState());

  Future<void> initialize({AppLocalizations? localizations}) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      _talker.info('Initializing home screen');
      await Future.wait([
        _loadRecentActivities(localizations: localizations),
        _loadSavedQrCodesCount(),
      ]);
      emit(state.copyWith(isLoading: false));
      _talker.info('Home screen initialized successfully');
    } catch (e, stackTrace) {
      _talker.error('Error initializing home screen', e, stackTrace);
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> refresh({AppLocalizations? localizations}) async {
    await initialize(localizations: localizations);
  }

  Future<void> _loadRecentActivities({AppLocalizations? localizations}) async {
    try {
      final qrCodes = await _getRecentActivitiesUseCase.execute(limit: 10);
      final activities = qrCodes
          .map((qrCode) => QrCodeToRecentActivityMapper.map(
                qrCode,
                localizations: localizations,
              ))
          .toList();
      emit(state.copyWith(recentActivities: activities));
      _talker.info('Loaded ${activities.length} recent activities');
    } catch (e, stackTrace) {
      _talker.error('Error loading recent activities', e, stackTrace);
      rethrow;
    }
  }

  Future<void> _loadSavedQrCodesCount() async {
    try {
      final count = await _getSavedQrCodesCountUseCase.execute();
      emit(state.copyWith(savedQrCodesCount: count));
      _talker.info('Loaded saved QR codes count: $count');
    } catch (e, stackTrace) {
      _talker.error('Error loading saved QR codes count', e, stackTrace);
      rethrow;
    }
  }
}
