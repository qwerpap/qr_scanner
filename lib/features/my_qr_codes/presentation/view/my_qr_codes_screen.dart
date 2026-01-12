import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/custom_sliver_app_bar.dart';
import 'package:qr_scanner/features/my_qr_codes/data/constants/categories_data.dart';
import 'package:qr_scanner/features/my_qr_codes/presentation/widgets/categories_list.dart';
import 'package:qr_scanner/features/my_qr_codes/presentation/widgets/qr_codes_grid.dart';

class MyQrCodesScreen extends StatefulWidget {
  const MyQrCodesScreen({super.key});

  @override
  State<MyQrCodesScreen> createState() => _MyQrCodesScreenState();
}

class _MyQrCodesScreenState extends State<MyQrCodesScreen> {
  String _activeCategoryId = CategoriesData.categories.first.id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: 'My QR Codes',
            showDivider: false,
            actions: [
              Center(
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.scaffoldBgColor,
                  ),
                  child: const Icon(
                    Icons.search,
                    color: AppColors.greyTextColor,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: CategoriesList(
              activeCategoryId: _activeCategoryId,
              onCategoryTap: (categoryId) {
                setState(() {
                  _activeCategoryId = categoryId;
                });
              },
            ),
          ),
          const QrCodesGrid(itemCount: 4),
        ],
      ),
    );
  }
}
