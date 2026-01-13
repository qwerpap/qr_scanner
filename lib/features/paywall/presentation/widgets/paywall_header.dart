import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner/core/core.dart';

class PaywallHeader extends StatelessWidget {
  const PaywallHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go(NavigationConstants.home);
              }
            },
            borderRadius: BorderRadius.circular(20),
            splashColor: AppColors.primaryColor.withOpacity(0.2),
            highlightColor: AppColors.primaryColor.withOpacity(0.1),
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(0, 0, 0, 0.06),
                    offset: Offset(0, 4),
                    blurRadius: 16,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: const Icon(
                Icons.close,
                color: AppColors.greyTextColor,
                fontWeight: FontWeight.bold,
                size: 20,
              ),
            ),
          ),
        ),
        Text(
          'Restore',
          style: AppFonts.titleLarge.copyWith(color: AppColors.greyTextColor),
        ),
      ],
    );
  }
}
