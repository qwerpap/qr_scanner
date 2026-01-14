import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/core/shared/widgets/custom_dropdown_button.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';
import 'package:qr_scanner/core/l10n/locale_provider.dart';
import 'package:qr_scanner/core/services/user_preferences_service.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  final UserPreferencesService _userPreferencesService = UserPreferencesService();
  String? _selectedLanguageCode;

  final Map<String, Locale> _languageMap = {
    'en': const Locale('en'),
    'ru': const Locale('ru'),
  };

  @override
  void initState() {
    super.initState();
    _loadCurrentLanguage();
  }

  Future<void> _loadCurrentLanguage() async {
    final savedLocale = await _userPreferencesService.getSavedLocale();
    if (mounted) {
      setState(() {
        _selectedLanguageCode = savedLocale?.languageCode ?? 'en';
      });
    }
  }

  String _getLanguageName(String code, BuildContext context) {
    switch (code) {
      case 'en':
        return context.l10n.english;
      case 'ru':
        return context.l10n.russian;
      default:
        return context.l10n.english;
    }
  }

  List<String> _getLanguageCodes() {
    return _languageMap.keys.toList();
  }

  @override
  Widget build(BuildContext context) {
    final currentCode = _selectedLanguageCode ?? 'en';

    return BaseContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.language,
            style: AppFonts.titleLarge.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          CustomDropdownButton<String>(
            items: _getLanguageCodes(),
            selectedValue: currentCode,
            onChanged: (code) {
              final locale = _languageMap[code];
              if (locale != null) {
                final localeProvider = LocaleProvider.of(context);
                if (localeProvider != null) {
                  localeProvider.onLocaleChanged(locale);
                  setState(() {
                    _selectedLanguageCode = code;
                  });
                }
              }
            },
            itemBuilder: (code) => _getLanguageName(code, context),
          ),
        ],
      ),
    );
  }
}
