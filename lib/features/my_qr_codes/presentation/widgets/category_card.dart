import 'package:flutter/material.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';
import 'package:qr_scanner/core/theme/app_fonts.dart';
import 'package:qr_scanner/features/my_qr_codes/data/models/category_model.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
    required this.isActive,
    required this.onTap,
  });

  final CategoryModel category;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(99),
          splashColor: AppColors.primaryColor,
          highlightColor: AppColors.primaryColor,
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(99),
              color: isActive ? null : AppColors.scaffoldBgColor,
              gradient: isActive ? AppColors.primaryGradient : null,
              border: isActive
                  ? Border.all(width: 1, color: AppColors.borderColor)
                  : null,
              boxShadow: isActive
                  ? [
                      BoxShadow(
                        color: const Color.fromRGBO(0, 0, 0, 0.06),
                        offset: const Offset(0, 4),
                        blurRadius: 16,
                        spreadRadius: 0,
                      ),
                    ]
                  : null,
            ),
            child: Text(
              category.title,
              style: AppFonts.titleMedium.copyWith(
                fontSize: 15,
                color: isActive
                    ? AppColors.whiteColor
                    : AppColors.greyTextColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
