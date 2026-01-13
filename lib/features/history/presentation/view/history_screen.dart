import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/shared/widgets/custom_sliver_app_bar.dart';
import 'package:qr_scanner/features/history/data/constants/history_categories_data.dart';
import 'package:qr_scanner/features/history/data/constants/history_data.dart';
import 'package:qr_scanner/features/history/presentation/widgets/history_categories_list.dart';
import 'package:qr_scanner/features/history/presentation/widgets/history_card.dart';
import 'package:qr_scanner/features/history/presentation/widgets/history_date_header.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  String _activeCategoryId = HistoryCategoriesData.categories.first.id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          CustomSliverAppBar(
            title: 'History',
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
                  child: Center(
                    child: SvgPicture.asset(
                      ImageSource.historyAppbar,
                      width: 15,
                      height: 15,
                      colorFilter: const ColorFilter.mode(
                        AppColors.greyTextColor,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SliverToBoxAdapter(
            child: HistoryCategoriesList(
              categories: HistoryCategoriesData.categories,
              activeCategoryId: _activeCategoryId,
              onCategoryTap: (categoryId) {
                setState(() {
                  _activeCategoryId = categoryId;
                });
              },
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate((context, groupIndex) {
              final group = HistoryData.groups[groupIndex];
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HistoryDateHeader(date: group.date),
                  ...group.items.map(
                    (item) => Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 8,
                      ),
                      child: HistoryCard(item: item),
                    ),
                  ),
                ],
              );
            }, childCount: HistoryData.groups.length),
          ),
        ],
      ),
    );
  }
}
