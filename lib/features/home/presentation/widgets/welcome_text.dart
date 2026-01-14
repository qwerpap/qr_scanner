import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/services/user_preferences_service.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';
import 'package:qr_scanner/core/theme/app_fonts.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';

class WelcomeText extends StatefulWidget {
  const WelcomeText({super.key});

  @override
  State<WelcomeText> createState() => _WelcomeTextState();
}

class _WelcomeTextState extends State<WelcomeText> {
  final UserPreferencesService _userPreferencesService =
      UserPreferencesService();
  String? _userName;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Reload when returning from profile screen
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    final name = await _userPreferencesService.getUserName();
    if (mounted) {
      setState(() {
        _userName = name;
        _isLoading = false;
      });
    }
  }

  String _welcomeText(BuildContext context) {
    if (_isLoading) {
      return context.l10n.welcome;
    }
    if (_userName != null && _userName!.isNotEmpty) {
      return context.l10n.welcomeWithName(_userName!);
    }
    return context.l10n.welcome;
  }

  String get _initial {
    if (_userName != null && _userName!.isNotEmpty) {
      return _userName!.substring(0, 1).toUpperCase();
    }
    return 'N';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                _welcomeText(context),
                style: AppFonts.displayLarge.copyWith(fontSize: 28),
              ),
            ),
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.push('/profile').then((_) {
                    _loadUserName();
                  });
                },
                borderRadius: BorderRadius.circular(24),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: AppColors.primaryGradient,
                  ),
                  child: Center(
                    child: Text(
                      _initial,
                      style: AppFonts.titleMedium.copyWith(
                        color: AppColors.whiteColor,
                        fontWeight: FontWeight.w700,
                        height: 1.1
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          context.l10n.manageYourQrCodesEasily,
          style: AppFonts.titleLarge.copyWith(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: AppColors.greyTextColor,
          ),
        ),
      ],
    );
  }
}
