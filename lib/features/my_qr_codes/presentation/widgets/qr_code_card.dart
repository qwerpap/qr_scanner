import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/core/constants/image_source.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/features/my_qr_codes/domain/models/created_qr_code_model.dart';
import 'package:qr_scanner/features/my_qr_codes/presentation/widgets/qr_card_context_menu.dart';

class QrCodeCard extends StatelessWidget {
  const QrCodeCard({
    super.key,
    required this.qrCode,
    this.onTap,
    this.onShare,
    this.onEdit,
    this.onDelete,
  });

  final CreatedQrCodeModel qrCode;
  final VoidCallback? onTap;
  final VoidCallback? onShare;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    qrCode.color,
                    qrCode.color.withOpacity(0.7),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(width: 1, color: AppColors.borderColor),
                boxShadow: [
                  BoxShadow(
                    color: const Color.fromRGBO(0, 0, 0, 0.06),
                    offset: const Offset(0, 4),
                    blurRadius: 16,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: Center(
                child: QrImageView(
                  data: qrCode.rawData,
                  version: QrVersions.auto,
                  size: 80,
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.whiteColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  qrCode.title,
                  style: AppFonts.titleMedium.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
              Builder(
                builder: (buttonContext) {
                  return GestureDetector(
                    onTap: () {
                      final RenderBox? renderBox =
                          buttonContext.findRenderObject() as RenderBox?;
                      if (renderBox != null) {
                        final Offset offset = renderBox.localToGlobal(Offset.zero);
                        final Size size = renderBox.size;

                        showMenu(
                          context: context,
                          color: Colors.transparent,
                          elevation: 0,
                          useRootNavigator: false,
                          position: RelativeRect.fromLTRB(
                            offset.dx + size.width - 200,
                            offset.dy - 120,
                            offset.dx + size.width,
                            offset.dy + size.height,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          items: [
                            PopupMenuItem(
                              padding: EdgeInsets.zero,
                              height: 0,
                              child: QrCardContextMenu(
                                onShareAll: () {
                                  Navigator.pop(context);
                                  onShare?.call();
                                },
                                onEdit: () {
                                  Navigator.pop(context);
                                  onEdit?.call();
                                },
                                onDelete: () {
                                  Navigator.pop(context);
                                  onDelete?.call();
                                },
                              ),
                            ),
                          ],
                        );
                      }
                    },
                    child: Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.scaffoldBgColor,
                      ),
                      child: const Icon(Icons.more_horiz, size: 18),
                    ),
                  );
                },
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            _getContentPreview(qrCode.rawData),
            style: AppFonts.titleMedium.copyWith(
              fontSize: 13,
              color: AppColors.greyTextColor,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Text(
                DateFormat('MMM dd, yyyy').format(qrCode.createdAt),
                style: AppFonts.titleMedium.copyWith(
                  fontSize: 13,
                  color: AppColors.greyColor,
                ),
              ),
              const Spacer(),
              SvgPicture.asset(ImageSource.eye),
              const SizedBox(width: 4),
              Text(
                '0',
                style: AppFonts.titleMedium.copyWith(
                  fontSize: 13,
                  color: AppColors.greyColor,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _getContentPreview(String rawData) {
    if (rawData.length > 30) {
      return '${rawData.substring(0, 27)}...';
    }
    return rawData;
  }
}
