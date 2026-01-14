import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../bloc/bloc_providers.dart';

import 'package:flutter/material.dart';

class UserPreferencesService {
  static const String _keyUserName = 'user_name';
  static const String _keyLanguageCode = 'language_code';
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

  Future<Locale?> getSavedLocale() async {
    try {
      _talker.info('Getting saved locale from SharedPreferences');
      final prefs = await SharedPreferences.getInstance();
      final languageCode = prefs.getString(_keyLanguageCode);
      if (languageCode != null) {
        _talker.info('Saved locale: $languageCode');
        return Locale(languageCode);
      }
      _talker.info('No saved locale found');
      return null;
    } catch (e, stackTrace) {
      _talker.error('Error getting saved locale', e, stackTrace);
      return null;
    }
  }

  Future<void> setSavedLocale(Locale locale) async {
    try {
      _talker.info('Setting saved locale: ${locale.languageCode}');
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keyLanguageCode, locale.languageCode);
      _talker.info('Locale saved successfully');
    } catch (e, stackTrace) {
      _talker.error('Error saving locale', e, stackTrace);
      rethrow;
    }
  }
}
