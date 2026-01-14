import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner/core/bloc/bloc_providers.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';
import 'package:qr_scanner/core/shared/widgets/custom_dialog.dart';
import 'package:qr_scanner/core/shared/widgets/custom_sliver_app_bar.dart';
import 'package:qr_scanner/features/history/data/constants/history_categories_data.dart';
import 'package:qr_scanner/features/history/presentation/bloc/history_bloc.dart';
import 'package:qr_scanner/features/history/presentation/bloc/history_event.dart';
import 'package:qr_scanner/features/history/presentation/bloc/history_state.dart';
import 'package:qr_scanner/features/history/presentation/widgets/history_categories_list.dart';
import 'package:qr_scanner/features/history/presentation/widgets/history_card.dart';
import 'package:qr_scanner/features/history/presentation/widgets/history_date_header.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<HistoryBloc>()..add(const HistoryInitialized()),
      child: Scaffold(
        body: BlocBuilder<HistoryBloc, HistoryState>(
          builder: (context, state) {
            if (state.isLoading && state.groups.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null && state.groups.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('${context.l10n.error}: ${state.errorMessage}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<HistoryBloc>().add(
                        const HistoryRefreshed(),
                      ),
                      child: Text(context.l10n.retry),
                    ),
                  ],
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                CustomSliverAppBar(
                  title: context.l10n.historyTitle,
                  showDivider: false,
                  showShadow: false,
                  automaticallyImplyLeading: false,
                  actions: [
                    Center(
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _showClearHistoryDialog(context),
                          borderRadius: BorderRadius.circular(20),
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
                      ),
                    ),
                  ],
                ),
                SliverToBoxAdapter(
                  child: HistoryCategoriesList(
                    categories: HistoryCategoriesData.getCategories(context),
                    activeCategoryId: state.activeCategoryId,
                    onCategoryTap: (categoryId) {
                      context.read<HistoryBloc>().add(
                        HistoryCategoryChanged(categoryId),
                      );
                    },
                  ),
                ),
                if (state.groups.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'No history yet',
                        style: AppFonts.titleMedium.copyWith(
                          color: AppColors.greyTextColor,
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.only(bottom: 160),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, groupIndex) {
                        final group = state.groups[groupIndex];
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
                                child: HistoryCard(
                                  item: item,
                                  onTap: () {
                                    context.push(
                                      '/scan_result',
                                      extra: {'qrData': item.qrData},
                                    );
                                  },
                                ),
                              ),
                            ),
                          ],
                        );
                      }, childCount: state.groups.length),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showClearHistoryDialog(BuildContext context) {
    CustomDialog.show(
      context: context,
      title: context.l10n.clearHistory,
      message: context.l10n.areYouSureYouWantToClearAllHistory,
      confirmText: context.l10n.clear,
      cancelText: 'Cancel',
      isDestructive: true,
      onConfirm: () {
        context.read<HistoryBloc>().add(const HistoryCleared());
      },
    );
  }
}
