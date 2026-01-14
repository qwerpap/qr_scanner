import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/core/shared/widgets/custom_dropdown_button.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  String _selectedLanguage = 'English';

  final List<String> _languages = [
    'English',
    'Русский',
    'Español',
  ];

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Language',
            style: AppFonts.titleLarge.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          CustomDropdownButton<String>(
            items: _languages,
            selectedValue: _selectedLanguage,
            onChanged: (value) {
              setState(() {
                _selectedLanguage = value;
              });
              // TODO: Implement language change logic
            },
            itemBuilder: (language) => language,
          ),
        ],
      ),
    );
  }
}
