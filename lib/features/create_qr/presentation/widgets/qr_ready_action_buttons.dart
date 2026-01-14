import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';

class QrReadyActionButtons extends StatelessWidget {
  const QrReadyActionButtons({
    super.key,
    required this.onShareTap,
    required this.onSaveTap,
    this.showSaveButton = true,
  });

  final VoidCallback onShareTap;
  final VoidCallback onSaveTap;
  final bool showSaveButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _ActionButton(
            icon: Icons.share,
            label: 'Share',
            onTap: onShareTap,
          ),
        ),
        if (showSaveButton) ...[
          const SizedBox(width: 12),
          Expanded(
            child: _ActionButton(
              icon: Icons.bookmark,
              label: 'Save',
              onTap: onSaveTap,
            ),
          ),
        ],
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color.fromRGBO(0, 0, 0, 0.06),
              offset: const Offset(0, 4),
              blurRadius: 16,
              spreadRadius: 0,
            ),
          ],
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              children: [
                Icon(icon, color: AppColors.greyTextColor, size: 24),
                const SizedBox(height: 8),
                Text(
                  label,
                  style: AppFonts.titleMedium.copyWith(
                    color: AppColors.greyTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
