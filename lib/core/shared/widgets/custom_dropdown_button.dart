import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';

class CustomDropdownButton<T> extends StatefulWidget {
  const CustomDropdownButton({
    super.key,
    required this.items,
    required this.selectedValue,
    required this.onChanged,
    required this.itemBuilder,
  });

  final List<T> items;
  final T selectedValue;
  final ValueChanged<T> onChanged;
  final String Function(T) itemBuilder;

  @override
  State<CustomDropdownButton<T>> createState() =>
      _CustomDropdownButtonState<T>();
}

class _CustomDropdownButtonState<T> extends State<CustomDropdownButton<T>> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          _showDropdownMenu(context);
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: AppColors.scaffoldBgColor,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.borderColor),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                widget.itemBuilder(widget.selectedValue),
                style: AppFonts.titleMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.greyTextColor,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDropdownMenu(BuildContext context) {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;
    
    // Get screen width and calculate menu width
    // Menu should be full width of BaseContainer content area
    // SliverPadding has 24 on each side, BaseContainer has 20 on each side
    final screenWidth = MediaQuery.of(context).size.width;
    final menuWidth = screenWidth - 48 - 40; // 24*2 (SliverPadding) + 20*2 (BaseContainer padding)
    
    // Calculate left position to align with BaseContainer content area
    // BaseContainer starts at 24 (SliverPadding) + 20 (BaseContainer padding) = 44
    final leftPosition = 24.0 + 20.0; // Align to BaseContainer content area

    showMenu<T>(
      context: context,
      color: Colors.transparent,
      elevation: 0,
      useRootNavigator: false,
      position: RelativeRect.fromLTRB(
        leftPosition,
        offset.dy + size.height + 4,
        leftPosition + menuWidth,
        offset.dy + size.height + 200,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      items: widget.items.map((item) {
        final isSelected = item == widget.selectedValue;
        return PopupMenuItem<T>(
          value: item,
          padding: EdgeInsets.zero,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.whiteColor,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: AppColors.borderColor,
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color.fromRGBO(0, 0, 0, 0.06),
                  offset: const Offset(0, 4),
                  blurRadius: 16,
                  spreadRadius: 0,
                ),
              ],
            ),
            margin: EdgeInsets.only(
              bottom: widget.items.indexOf(item) < widget.items.length - 1
                  ? 4
                  : 0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.itemBuilder(item),
                  style: AppFonts.titleMedium.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: isSelected
                        ? AppColors.blackColor
                        : AppColors.greyTextColor,
                  ),
                ),
                if (isSelected)
                  Icon(
                    Icons.check_circle,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
              ],
            ),
          ),
        );
      }).toList(),
    ).then((value) {
      if (value != null) {
        widget.onChanged(value);
      }
    });
  }
}
