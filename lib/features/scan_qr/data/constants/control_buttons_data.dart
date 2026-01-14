import 'package:flutter/material.dart';
import 'package:qr_scanner/features/scan_qr/data/models/control_button_model.dart';

class ControlButtonsData {
  static List<ControlButtonModel> getButtons({
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
        label: 'Flash',
        icon: Icons.flash_on,
        onTap: onFlashTap,
        isActive: isFlashActive,
      ),
      ControlButtonModel(
        id: 'switch',
        label: 'Switch',
        icon: Icons.cameraswitch,
        onTap: onSwitchTap,
        isActive: isSwitchActive,
      ),
      ControlButtonModel(
        id: 'gallery',
        label: 'Gallery',
        icon: Icons.photo_library,
        onTap: onGalleryTap,
        isActive: isGalleryActive,
      ),
    ];
  }
}
