import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/features/create_qr/presentation/widgets/color_circle.dart';

class DesignOptionsSection extends StatelessWidget {
  const DesignOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Design Options', style: AppFonts.titleLarge),
        const SizedBox(height: 16),
        BaseContainer(
          padding: const EdgeInsets.all(17),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Color', style: AppFonts.titleMedium),
                  Row(
                    children: [
                      ColorCircle(color: const Color.fromRGBO(0, 0, 0, 1)),
                      const SizedBox(width: 8),
                      ColorCircle(color: AppColors.primaryColor),
                      const SizedBox(width: 8),
                      ColorCircle(color: AppColors.greenColor),
                      const SizedBox(width: 8),
                      ColorCircle(color: AppColors.orangeColor),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('+ Add Logo', style: AppFonts.titleMedium),
                  Text(
                    'Pro Feature',
                    style: AppFonts.titleMedium.copyWith(
                      fontSize: 13,
                      color: AppColors.greyTextColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
