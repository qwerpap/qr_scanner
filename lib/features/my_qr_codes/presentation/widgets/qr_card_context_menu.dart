import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';

class QrCardContextMenu extends StatelessWidget {
  const QrCardContextMenu({
    super.key,
    this.onShareAll,
    this.onEdit,
    this.onDelete,
  });

  final VoidCallback? onShareAll;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(width: 1, color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.06),
            offset: const Offset(0, 2.83),
            blurRadius: 11.32,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: const Color.fromRGBO(122, 203, 255, 0.45),
            offset: const Offset(0, 0),
            blurRadius: 24.68,
            spreadRadius: 0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 11),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildActionButton(
              label: 'Share All',
              icon: Icons.share,
              color: AppColors.greenColor,
              onTap: onShareAll ?? () {},
            ),
            const SizedBox(width: 16),
            _buildActionButton(
              label: 'Edit',
              icon: Icons.edit,
              color: AppColors.primaryColor,
              onTap: onEdit ?? () {},
            ),
            const SizedBox(width: 16),
            _buildActionButton(
              label: 'Delete',
              icon: Icons.delete,
              color: AppColors.orangeColor,
              onTap: onDelete ?? () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Icon(icon, color: AppColors.whiteColor, size: 24),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: AppFonts.titleMedium.copyWith(
              fontSize: 11,
              color: AppColors.greyTextColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
