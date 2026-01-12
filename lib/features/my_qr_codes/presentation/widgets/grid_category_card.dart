import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/features/my_qr_codes/presentation/widgets/qr_card_context_menu.dart';

class GridCategoryCard extends StatelessWidget {
  const GridCategoryCard({super.key, required this.iconPath});

  final String iconPath;

  @override
  Widget build(BuildContext context) {
    return BaseContainer(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 96,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              gradient: AppColors.primaryGradient,
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
              child: SvgPicture.asset(
                iconPath,
                width: 50,
                height: 50,
                colorFilter: const ColorFilter.mode(
                  AppColors.whiteColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Contact Info',
                style: AppFonts.titleMedium.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
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
                                  // TODO: Add share all action
                                },
                                onEdit: () {
                                  Navigator.pop(context);
                                  // TODO: Add edit action
                                },
                                onDelete: () {
                                  Navigator.pop(context);
                                  // TODO: Add delete action
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
                      child: Icon(Icons.more_horiz, size: 18),
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'John Doe vCard',
            style: AppFonts.titleMedium.copyWith(
              fontSize: 13,
              color: AppColors.greyTextColor,
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Text(
                'Dec 12, 2024',
                style: AppFonts.titleMedium.copyWith(
                  fontSize: 13,
                  color: AppColors.greyColor,
                ),
              ),
              Spacer(),
              SvgPicture.asset(ImageSource.eye),
              SizedBox(width: 4),
              Text(
                '12',
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
}
