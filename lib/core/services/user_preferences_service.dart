import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../bloc/bloc_providers.dart';

class UserPreferencesService {
  static const String _keyUserName = 'user_name';
  final Talker _talker = getIt<Talker>();

  Future<String?> getUserName() async {
    try {
      _talker.info('Getting user name from SharedPreferences');
      final prefs = await SharedPreferences.getInstance();
      final userName = prefs.getString(_keyUserName);
      _talker.info('User name: ${userName ?? "not set"}');
      return userName;
    } catch (e, stackTrace) {
      _talker.error('Error getting user name', e, stackTrace);
      return null;
    }
  }

  Future<void> setUserName(String name) async {
    try {
      _talker.info('Setting user name: $name');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyUserName, name);
      _talker.info('User name saved successfully');
    } catch (e, stackTrace) {
      _talker.error('Error saving user name', e, stackTrace);
      rethrow;
    }
  }

  Future<bool> hasUserName() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.containsKey(_keyUserName);
    } catch (e, stackTrace) {
      _talker.error('Error checking user name', e, stackTrace);
      return false;
    }
  }
}
