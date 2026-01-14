import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';

class OnboardingPagination extends StatelessWidget {
  const OnboardingPagination({
    super.key,
    required this.currentIndex,
    required this.itemCount,
  });

  final int currentIndex;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        itemCount,
        (index) => Container(
          width: index == currentIndex ? 32 : 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: index == currentIndex
                ? AppColors.primaryColor
                : const Color.fromRGBO(209, 213, 219, 1),
          ),
        ),
      ),
    );
  }
}
