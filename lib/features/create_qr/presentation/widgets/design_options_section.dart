import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/features/create_qr/presentation/widgets/color_circle.dart';
import 'package:qr_scanner/features/create_qr/presentation/cubit/create_qr_code_cubit.dart';
import 'package:qr_scanner/features/create_qr/presentation/cubit/create_qr_code_state.dart';

class DesignOptionsSection extends StatelessWidget {
  const DesignOptionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateQrCodeCubit, CreateQrCodeState>(
      builder: (context, state) {
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
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<CreateQrCodeCubit>()
                                  .changeColor(const Color.fromRGBO(0, 0, 0, 1));
                            },
                            child: ColorCircle(
                              color: const Color.fromRGBO(0, 0, 0, 1),
                              isSelected: state.selectedColor.value ==
                                  const Color.fromRGBO(0, 0, 0, 1).value,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<CreateQrCodeCubit>()
                                  .changeColor(AppColors.primaryColor);
                            },
                            child: ColorCircle(
                              color: AppColors.primaryColor,
                              isSelected: state.selectedColor.value ==
                                  AppColors.primaryColor.value,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<CreateQrCodeCubit>()
                                  .changeColor(AppColors.greenColor);
                            },
                            child: ColorCircle(
                              color: AppColors.greenColor,
                              isSelected: state.selectedColor.value ==
                                  AppColors.greenColor.value,
                            ),
                          ),
                          const SizedBox(width: 8),
                          GestureDetector(
                            onTap: () {
                              context
                                  .read<CreateQrCodeCubit>()
                                  .changeColor(AppColors.orangeColor);
                            },
                            child: ColorCircle(
                              color: AppColors.orangeColor,
                              isSelected: state.selectedColor.value ==
                                  AppColors.orangeColor.value,
                            ),
                          ),
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
      },
    );
  }
}
