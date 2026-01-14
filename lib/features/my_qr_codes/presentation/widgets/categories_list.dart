import 'package:flutter/material.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';
import 'package:qr_scanner/features/my_qr_codes/data/constants/categories_data.dart';
import 'package:qr_scanner/features/my_qr_codes/presentation/widgets/category_card.dart';

class CategoriesList extends StatelessWidget {
  const CategoriesList({
    super.key,
    required this.activeCategoryId,
    required this.onCategoryTap,
  });

  final String activeCategoryId;
  final ValueChanged<String> onCategoryTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, 0.06),
            offset: const Offset(0, 4),
            blurRadius: 16,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        scrollDirection: Axis.horizontal,
        itemCount: CategoriesData.getCategories(context).length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = CategoriesData.getCategories(context)[index];
          return CategoryCard(
            category: category,
            isActive: category.id == activeCategoryId,
            onTap: () => onCategoryTap(category.id),
          );
        },
      ),
    );
  }
}
