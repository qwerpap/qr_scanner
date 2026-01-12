import 'package:flutter/material.dart';
import 'package:qr_scanner/features/scan_result/presentation/widgets/action_button.dart';

class ActionButtonsRow extends StatelessWidget {
  const ActionButtonsRow({
    super.key,
    this.onCopy,
    this.onShare,
    this.onSave,
  });

  final VoidCallback? onCopy;
  final VoidCallback? onShare;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ActionButton(
            icon: Icons.copy,
            label: 'Copy',
            onTap: onCopy ?? () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ActionButton(
            icon: Icons.share,
            label: 'Share',
            onTap: onShare ?? () {},
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: ActionButton(
            icon: Icons.bookmark_border,
            label: 'Save',
            onTap: onSave ?? () {},
          ),
        ),
      ],
    );
  }
}
