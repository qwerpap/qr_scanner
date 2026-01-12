import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner/core/navigation/data/constants/navigation_constants.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';
import 'package:qr_scanner/core/theme/app_fonts.dart';

class CustomSliverAppBar extends StatelessWidget {
  const CustomSliverAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.automaticallyImplyLeading = true,
    this.centerTitle = false,
    this.elevation,
    this.backgroundColor,
    this.foregroundColor,
    this.showCloseButton = false,
    this.showDivider = true,
    this.pinned = true,
    this.floating = false,
  });

  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool automaticallyImplyLeading;
  final bool centerTitle;
  final double? elevation;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool showCloseButton;
  final bool showDivider;
  final bool pinned;
  final bool floating;

  @override
  Widget build(BuildContext context) {
    final List<Widget> finalActions = actions ?? [];
    if (showCloseButton) {
      finalActions.add(_buildCloseButton(context));
    }

    return SliverAppBar(
      title: title != null
          ? Padding(
              padding: const EdgeInsets.only(left: 24, bottom: 10),
              child: Text(
                title!,
                style: AppFonts.titleLarge.copyWith(fontSize: 22),
              ),
            )
          : null,
      titleSpacing: 0,
      actions: finalActions.isEmpty
          ? null
          : [
              Padding(
                padding: const EdgeInsets.only(right: 24),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: finalActions,
                ),
              ),
            ],
      leading: leading != null
          ? Padding(padding: const EdgeInsets.only(left: 24), child: leading)
          : null,
      automaticallyImplyLeading: automaticallyImplyLeading,
      centerTitle: centerTitle,
      elevation: elevation ?? 0,
      backgroundColor: backgroundColor ?? AppColors.whiteColor,
      foregroundColor: foregroundColor,
      pinned: pinned,
      floating: floating,
      bottom: showDivider
          ? PreferredSize(
              preferredSize: const Size.fromHeight(0),
              child: Container(
                height: 1,
                color: const Color.fromRGBO(229, 231, 235, 1),
              ),
            )
          : null,
    );
  }

  Widget _buildCloseButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 24),
      child: Center(
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(NavigationConstants.home);
              }
            },
            borderRadius: BorderRadius.circular(24),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.scaffoldBgColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.06),
                    offset: const Offset(0, 4),
                    blurRadius: 16,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: const Icon(
                Icons.close,
                color: AppColors.blackColor,
                size: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
