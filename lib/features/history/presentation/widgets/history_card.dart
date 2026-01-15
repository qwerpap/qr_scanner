import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/core/shared/widgets/container_with_icon.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';
import 'package:qr_scanner/core/theme/app_fonts.dart';
import 'package:qr_scanner/features/history/domain/models/history_item_model.dart';

class HistoryCard extends StatelessWidget {
  // Map с константными IconData для всех возможных иконок
  // Используем константные IconData для tree-shaking
  static const Map<int, IconData> _iconDataMap = {
    0xe157: Icons.link, // url
    0xe63e: Icons.wifi, // wifi
    0xe8d4: Icons.contact_page, // vcard
    0xe0be: Icons.email, // email
    0xe0b0: Icons.phone, // phone
    0xe0d8: Icons.sms, // sms
    0xe8b8: Icons.qr_code_scanner, // text, unknown
  };
  const HistoryCard({
    super.key,
    required this.item,
    this.onTap,
  });

  final HistoryItemModel item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: BaseContainer(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              ContainerWithIcon(
                iconData: _iconDataMap[item.iconData] ?? Icons.qr_code_scanner,
                color: Color(item.iconColor),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.title, style: AppFonts.titleLarge),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            item.content,
                            style: AppFonts.titleMedium.copyWith(
                              color: AppColors.greyTextColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () => _onCopy(context),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.scaffoldBgColor,
                            ),
                            child: const Icon(
                              Icons.copy,
                              color: AppColors.greyTextColor,
                              size: 16,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        InkWell(
                          onTap: () => _onShare(context),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.scaffoldBgColor,
                            ),
                            child: const Icon(
                              Icons.share,
                              color: AppColors.greyTextColor,
                              size: 16,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 3),
                    Row(
                      children: [
                        Text(
                          item.status,
                          style: AppFonts.titleSmall.copyWith(
                            color: AppColors.greyColor,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          ' • ',
                          style: AppFonts.titleSmall.copyWith(
                            color: AppColors.greyColor,
                            fontSize: 13,
                          ),
                        ),
                        Text(
                          item.timestamp,
                          style: AppFonts.titleSmall.copyWith(
                            color: AppColors.greyColor,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onCopy(BuildContext context) async {
    try {
      await Clipboard.setData(ClipboardData(text: item.qrData));
    } catch (_) {
      // ignore
    }
  }

  Future<void> _onShare(BuildContext context) async {
    try {
      await Share.share(item.qrData);
    } catch (_) {
      // ignore
    }
  }
}
