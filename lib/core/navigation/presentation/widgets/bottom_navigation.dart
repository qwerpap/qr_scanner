import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/app_colors.dart';
import '../../data/constants/bottom_navigation_constants.dart';
import '../../data/constants/navigation_colors.dart';
import '../../data/constants/navigation_icons.dart';
import '../../data/models/navigation_item.dart';
import '../cubit/navigation_cubit.dart';
import '../cubit/navigation_state.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  static const double _barHeight = 80.0;
  static const double _fabWidth = 52.0;
  static const double _horizontalPadding = 8.0;
  static const double _iconSize = 20.0;
  static const double _iconTextSpacing = 4.0;
  static const double _itemVerticalPadding = 8.0;
  static const double _rippleBorderRadius = 12.0;
  static const Duration _animationDuration = Duration(milliseconds: 200);
  static const Curve _animationCurve = Curves.easeInOut;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationState>(
      buildWhen: (previous, current) => previous.currentIndex != current.currentIndex,
      builder: (context, state) {
        final cubit = context.read<NavigationCubit>();

        return BottomAppBar(
          height: _barHeight,
          color: AppColors.whiteColor,
          elevation: 8,
          shadowColor: Colors.black.withOpacity(0.1),
          notchMargin: 8,
          padding: EdgeInsets.zero,
          child: SafeArea(
            top: false,
            minimum: EdgeInsets.zero,
            child: SizedBox(
              height: _barHeight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavigationItem(
                      context: context,
                      item: BottomNavigationConstants.navigationItems[0],
                      index: 0,
                      currentIndex: state.currentIndex,
                      cubit: cubit,
                    ),
                    _buildNavigationItem(
                      context: context,
                      item: BottomNavigationConstants.navigationItems[1],
                      index: 1,
                      currentIndex: state.currentIndex,
                      cubit: cubit,
                    ),
                    const SizedBox(width: _fabWidth),
                    _buildNavigationItem(
                      context: context,
                      item: BottomNavigationConstants.navigationItems[2],
                      index: 2,
                      currentIndex: state.currentIndex,
                      cubit: cubit,
                    ),
                    _buildNavigationItem(
                      context: context,
                      item: BottomNavigationConstants.navigationItems[3],
                      index: 3,
                      currentIndex: state.currentIndex,
                      cubit: cubit,
                    ),
                  ],
                ),
              ),
            ),
          ),
          shape: const AutomaticNotchedShape(
            RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(99)),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavigationItem({
    required BuildContext context,
    required NavigationItem item,
    required int index,
    required int currentIndex,
    required NavigationCubit cubit,
  }) {
    final isSelected = index == currentIndex;
    final iconColor = isSelected
        ? NavigationColors.selectedIconColor
        : NavigationColors.unselectedIconColor;

    final textColor = isSelected
        ? NavigationColors.selectedIconColor
        : AppColors.greyColor;

    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => cubit.navigateToRoute(context, item.route),
          borderRadius: BorderRadius.circular(_rippleBorderRadius),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: _itemVerticalPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: _iconSize,
                  height: _iconSize,
                  child: _buildIcon(item, iconColor),
                ),
                const SizedBox(height: _iconTextSpacing),
                AnimatedDefaultTextStyle(
                  duration: _animationDuration,
                  curve: _animationCurve,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                        color: textColor,
                      ) ??
                      TextStyle(color: textColor),
                  child: Text(item.label),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(NavigationItem item, Color iconColor) {
    return SvgPicture.asset(
      item.iconPath,
      colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
      width: _iconSize,
      height: _iconSize,
      fit: BoxFit.contain,
      errorBuilder: (context, error, stackTrace) {
        return Icon(
          NavigationIcons.getIconByRoute(item.route),
          color: iconColor,
          size: _iconSize,
        );
      },
    );
  }
}

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({super.key});

  static const double _iconSize = 24.0;
  static const double _shadowBlur1 = 16.0;
  static const double _shadowBlur2 = 24.0;
  static const double _shadowOffsetY = 4.0;
  static const double _shadowOpacity1 = 0.06;
  static const double _shadowOpacity2 = 0.3;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, _shadowOpacity1),
            offset: const Offset(0, _shadowOffsetY),
            blurRadius: _shadowBlur1,
            spreadRadius: 0,
          ),
          BoxShadow(
            color: AppColors.greenColor.withOpacity(_shadowOpacity2),
            offset: Offset.zero,
            blurRadius: _shadowBlur2,
            spreadRadius: 0,
          ),
        ],
      ),
      child: FloatingActionButton(
        onPressed: () {
          final currentPath = GoRouterState.of(context).uri.path;
          if (currentPath != '/create_qr_code') {
            context.push('/create_qr_code');
          }
        },
        backgroundColor: AppColors.greenColor,
        elevation: 0,
        highlightElevation: 0,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: AppColors.whiteColor,
          size: _iconSize,
        ),
      ),
    );
  }
}
