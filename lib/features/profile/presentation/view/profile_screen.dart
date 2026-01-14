import 'package:flutter/material.dart';
import 'package:qr_scanner/core/services/user_preferences_service.dart';
import 'package:qr_scanner/core/shared/widgets/custom_sliver_app_bar.dart';
import 'package:qr_scanner/features/profile/presentation/widgets/language_selector.dart';
import 'package:qr_scanner/features/profile/presentation/widgets/name_input_dialog.dart';
import 'package:qr_scanner/features/profile/presentation/widgets/subscription_info.dart';
import 'package:qr_scanner/features/profile/presentation/widgets/user_info_section.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final UserPreferencesService _userPreferencesService =
      UserPreferencesService();
  String? _userName;

  @override
  void initState() {
    super.initState();
    _loadUserName();
    _checkAndShowNameDialog();
  }

  Future<void> _loadUserName() async {
    final name = await _userPreferencesService.getUserName();
    if (mounted) {
      setState(() {
        _userName = name;
      });
    }
  }

  Future<void> _checkAndShowNameDialog() async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (!mounted) return;

    final hasName = await _userPreferencesService.hasUserName();
    if (!hasName) {
      final name = await NameInputDialog.show(context);
      if (name != null && mounted) {
        await _userPreferencesService.setUserName(name);
        setState(() {
          _userName = name;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const CustomSliverAppBar(
            title: 'Profile',
            showCloseButton: true,
            showDivider: false,
            showShadow: false,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 20),
                UserInfoSection(
                  userName: _userName,
                  hasSubscription: false, // TODO: Replace with actual subscription status
                  onNameTap: () async {
                    final name = await NameInputDialog.show(context);
                    if (name != null && mounted) {
                      await _userPreferencesService.setUserName(name);
                      setState(() {
                        _userName = name;
                      });
                    }
                  },
                ),
                const SizedBox(height: 32),
                const SubscriptionInfo(),
                const SizedBox(height: 32),
                const LanguageSelector(),
                const SizedBox(height: 32),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
