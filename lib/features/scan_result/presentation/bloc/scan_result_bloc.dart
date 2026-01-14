import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:share_plus/share_plus.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../../core/bloc/bloc_providers.dart';
import '../../../../core/services/app_side_effect.dart';
import '../../../../core/services/app_side_effect_controller.dart';
import '../../../../core/services/notification_type.dart';
import '../../domain/entities/qr_code_type.dart';
import '../../domain/usecases/detect_qr_code_type_usecase.dart';
import '../../domain/usecases/save_qr_code_usecase.dart';
import 'scan_result_event.dart';
import 'scan_result_state.dart';

class ScanResultBloc extends Bloc<ScanResultEvent, ScanResultState> {
  final DetectQrCodeTypeUseCase _detectQrCodeTypeUseCase;
  final SaveQrCodeUseCase _saveQrCodeUseCase;
  final Talker _talker = getIt<Talker>();
  final AppSideEffectController _sideEffectController;

  ScanResultBloc({
    required DetectQrCodeTypeUseCase detectQrCodeTypeUseCase,
    required SaveQrCodeUseCase saveQrCodeUseCase,
    required AppSideEffectController sideEffectController,
  }) : _detectQrCodeTypeUseCase = detectQrCodeTypeUseCase,
       _saveQrCodeUseCase = saveQrCodeUseCase,
       _sideEffectController = sideEffectController,
       super(const ScanResultState()) {
    on<ScanResultInitialized>(_onInitialized);
    on<ScanResultCopyRequested>(_onCopyRequested);
    on<ScanResultShareRequested>(_onShareRequested);
    on<ScanResultSaveRequested>(_onSaveRequested);
    on<ScanResultOpenLinkRequested>(_onOpenLinkRequested);
    on<ScanResultNotificationDismissed>(_onNotificationDismissed);
  }

  Future<void> _onInitialized(
    ScanResultInitialized event,
    Emitter<ScanResultState> emit,
  ) async {
    try {
      _talker.info('Initializing scan result with data: ${event.qrData}');
      final qrCodeData = _detectQrCodeTypeUseCase.execute(event.qrData);
      emit(state.copyWith(qrCodeData: qrCodeData, isLoading: false));
      _talker.info('QR code type detected: ${qrCodeData.type.displayName}');
    } catch (e, stackTrace) {
      _talker.error('Error initializing scan result', e, stackTrace);
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onCopyRequested(
    ScanResultCopyRequested event,
    Emitter<ScanResultState> emit,
  ) async {
    try {
      if (state.qrCodeData == null) return;

      _talker.info('Copying QR code data to clipboard');
      await Clipboard.setData(ClipboardData(text: state.qrCodeData!.rawData));
      _talker.info('QR code data copied successfully');
      _sideEffectController.emit(
        const ShowNotificationSideEffect(NotificationType.copied),
      );
    } catch (e, stackTrace) {
      _talker.error('Error copying QR code data', e, stackTrace);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onShareRequested(
    ScanResultShareRequested event,
    Emitter<ScanResultState> emit,
  ) async {
    try {
      if (state.qrCodeData == null) return;

      _talker.info('Sharing QR code data');
      await Share.share(state.qrCodeData!.rawData);
      _talker.info('QR code data shared successfully');
      _sideEffectController.emit(
        const ShowNotificationSideEffect(NotificationType.shared),
      );
    } catch (e, stackTrace) {
      _talker.error('Error sharing QR code data', e, stackTrace);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onSaveRequested(
    ScanResultSaveRequested event,
    Emitter<ScanResultState> emit,
  ) async {
    try {
      if (state.qrCodeData == null) return;

      emit(state.copyWith(isSaving: true));
      _talker.info('Saving QR code to local storage');
      await _saveQrCodeUseCase.execute(state.qrCodeData!);
      emit(state.copyWith(isSaving: false, isSaved: true));
      _talker.info('QR code saved successfully');
      _sideEffectController.emit(
        const ShowNotificationSideEffect(NotificationType.saved),
      );
    } catch (e, stackTrace) {
      _talker.error('Error saving QR code', e, stackTrace);
      emit(state.copyWith(isSaving: false, errorMessage: e.toString()));
    }
  }

  Future<void> _onOpenLinkRequested(
    ScanResultOpenLinkRequested event,
    Emitter<ScanResultState> emit,
  ) async {
    try {
      if (state.qrCodeData == null) return;
      if (state.qrCodeData!.type != QrCodeType.url) {
        _talker.warning('Cannot open link: QR code is not a URL');
        return;
      }

      String urlString = state.qrCodeData!.rawData.trim();
      
      if (!urlString.startsWith('http://') && !urlString.startsWith('https://')) {
        urlString = 'https://$urlString';
      }

      final url = Uri.parse(urlString);
      _talker.info('Opening URL: $url');

      try {
        final launched = await launchUrl(
          url,
          mode: LaunchMode.externalApplication,
        );
        
        if (launched) {
          emit(state.copyWith(isLinkOpened: true));
          _talker.info('URL opened successfully');
        } else {
          _talker.warning('Failed to launch URL: $url');
          _sideEffectController.emit(
            const ShowNotificationSideEffect(NotificationType.urlOpenError),
          );
        }
      } catch (launchError) {
        _talker.warning('Error launching URL: $url, error: $launchError');
        
        final canLaunch = await canLaunchUrl(url);
        if (!canLaunch) {
          _talker.warning('URL cannot be launched: $url');
        }
        
        _sideEffectController.emit(
          const ShowNotificationSideEffect(NotificationType.urlOpenError),
        );
      }
    } catch (e, stackTrace) {
      _talker.error('Error opening URL', e, stackTrace);
      _sideEffectController.emit(
        const ShowNotificationSideEffect(NotificationType.urlOpenError),
      );
    }
  }

  void _onNotificationDismissed(
    ScanResultNotificationDismissed event,
    Emitter<ScanResultState> emit,
  ) {
    emit(state.copyWith(isCopied: false));
  }
}
