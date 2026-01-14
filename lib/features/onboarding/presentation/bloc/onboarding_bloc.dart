import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/core/bloc/bloc_providers.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../domain/usecases/check_onboarding_completed_usecase.dart';
import '../../domain/usecases/set_onboarding_completed_usecase.dart';
import 'onboarding_event.dart';
import 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final CheckOnboardingCompletedUseCase _checkOnboardingCompletedUseCase;
  final SetOnboardingCompletedUseCase _setOnboardingCompletedUseCase;
  final Talker _talker;

  OnboardingBloc({
    required CheckOnboardingCompletedUseCase checkOnboardingCompletedUseCase,
    required SetOnboardingCompletedUseCase setOnboardingCompletedUseCase,
    Talker? talker,
  }) : _checkOnboardingCompletedUseCase = checkOnboardingCompletedUseCase,
       _setOnboardingCompletedUseCase = setOnboardingCompletedUseCase,
       _talker = talker ?? getIt<Talker>(),
       super(const OnboardingInitial()) {
    on<CheckOnboardingStatus>(_onCheckOnboardingStatus);
    on<CompleteOnboarding>(_onCompleteOnboarding);
  }

  Future<void> _onCheckOnboardingStatus(
    CheckOnboardingStatus event,
    Emitter<OnboardingState> emit,
  ) async {
    try {
      emit(const OnboardingChecking());
      _talker.info('Checking onboarding status');

      final isCompleted = await _checkOnboardingCompletedUseCase()
          .timeout(
            const Duration(seconds: 5),
            onTimeout: () {
              _talker.warning('Timeout reading onboarding status, defaulting to not completed');
              return false;
            },
          );

      if (isCompleted) {
        _talker.info('Onboarding already completed, navigating to scan-qr');
        emit(const OnboardingCompleted());
      } else {
        _talker.info('Onboarding not completed, navigating to onboarding');
        emit(const OnboardingNotCompleted());
      }
    } catch (e, stackTrace) {
      _talker.error('Error checking onboarding status', e, stackTrace);
      emit(OnboardingError(e.toString()));
    }
  }

  Future<void> _onCompleteOnboarding(
    CompleteOnboarding event,
    Emitter<OnboardingState> emit,
  ) async {
    try {
      _talker.info('Completing onboarding');
      await _setOnboardingCompletedUseCase(true);
      _talker.info('Onboarding completed successfully');
      emit(const OnboardingCompleted());
    } catch (e, stackTrace) {
      _talker.error('Error completing onboarding', e, stackTrace);
      emit(OnboardingError(e.toString()));
    }
  }
}
