import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';

class OnboardingLocalDataSource {
  static const String _keyOnboardingCompleted = 'onboarding_completed';
  final Talker _talker;

  OnboardingLocalDataSource({required Talker talker}) : _talker = talker;

  Future<bool> isOnboardingCompleted() async {
    try {
      _talker.info('Checking onboarding status from SharedPreferences');
      final prefs = await SharedPreferences.getInstance();
      final result = prefs.getBool(_keyOnboardingCompleted) ?? false;
      _talker.info('Onboarding status: $result');
      return result;
    } catch (e, stackTrace) {
      _talker.error('Error reading onboarding status', e, stackTrace);
      rethrow;
    }
  }

  Future<void> setOnboardingCompleted(bool value) async {
    try {
      _talker.info('Setting onboarding completed: $value');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(_keyOnboardingCompleted, value);
      _talker.info('Onboarding completed flag saved successfully');
    } catch (e, stackTrace) {
      _talker.error('Error saving onboarding status', e, stackTrace);
      rethrow;
    }
  }
}
