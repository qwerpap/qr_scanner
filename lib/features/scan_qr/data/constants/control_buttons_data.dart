import 'package:flutter/material.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';
import 'package:qr_scanner/features/scan_qr/data/models/control_button_model.dart';

class ControlButtonsData {
  static List<ControlButtonModel> getButtons({
    required BuildContext context,
    required VoidCallback onFlashTap,
    required VoidCallback onSwitchTap,
    required VoidCallback onGalleryTap,
    bool isFlashActive = false,
    bool isSwitchActive = false,
    bool isGalleryActive = false,
  }) {
    return [
      ControlButtonModel(
        id: 'flash',
        label: context.l10n.flash,
        icon: Icons.flash_on,
        onTap: onFlashTap,
        isActive: isFlashActive,
      ),
      ControlButtonModel(
        id: 'switch',
        label: context.l10n.switchCamera,
        icon: Icons.cameraswitch,
        onTap: onSwitchTap,
        isActive: isSwitchActive,
      ),
      ControlButtonModel(
        id: 'gallery',
        label: context.l10n.gallery,
        icon: Icons.photo_library,
        onTap: onGalleryTap,
        isActive: isGalleryActive,
      ),
    ];
  }
}
