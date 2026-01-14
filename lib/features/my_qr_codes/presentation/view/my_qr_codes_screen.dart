import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner/core/bloc/bloc_providers.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:share_plus/share_plus.dart';
import 'package:qr_scanner/core/shared/widgets/custom_dialog.dart';
import 'package:qr_scanner/core/shared/widgets/custom_sliver_app_bar.dart';
import 'package:qr_scanner/core/shared/widgets/custom_text_field.dart';
import 'package:qr_scanner/features/my_qr_codes/presentation/bloc/my_qr_codes_bloc.dart';
import 'package:qr_scanner/features/my_qr_codes/presentation/bloc/my_qr_codes_event.dart';
import 'package:qr_scanner/features/my_qr_codes/presentation/bloc/my_qr_codes_state.dart';
import 'package:qr_scanner/features/my_qr_codes/presentation/widgets/categories_list.dart';
import 'package:qr_scanner/features/my_qr_codes/presentation/widgets/qr_code_card.dart';

class MyQrCodesScreen extends StatefulWidget {
  const MyQrCodesScreen({super.key});

  @override
  State<MyQrCodesScreen> createState() => _MyQrCodesScreenState();
}

class _MyQrCodesScreenState extends State<MyQrCodesScreen> {
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<MyQrCodesBloc>()..add(const MyQrCodesInitialized()),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocBuilder<MyQrCodesBloc, MyQrCodesState>(
          builder: (context, state) {
            if (state.isLoading && state.qrCodes.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.errorMessage != null && state.qrCodes.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Error: ${state.errorMessage}'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<MyQrCodesBloc>().add(
                        const MyQrCodesRefreshed(),
                      ),
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return CustomScrollView(
              slivers: [
                CustomSliverAppBar(
                  title: 'My QR Codes',
                  showDivider: false,
                  showShadow: false,
                  actions: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _isSearching = !_isSearching;
                            if (!_isSearching) {
                              context.read<MyQrCodesBloc>().add(
                                const MyQrCodesSearchChanged(''),
                              );
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.scaffoldBgColor,
                          ),
                          child: Icon(
                            _isSearching ? Icons.close : Icons.search,
                            color: AppColors.greyTextColor,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (_isSearching)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 16,
                      ),
                      child: CustomTextField(
                        hintText: 'Search QR codes...',
                        initialValue: state.searchQuery ?? '',
                        showLinkIcon: false,
                        onChanged: (value) {
                          context.read<MyQrCodesBloc>().add(
                            MyQrCodesSearchChanged(value),
                          );
                        },
                      ),
                    ),
                  ),
                if (!_isSearching)
                  SliverToBoxAdapter(
                    child: CategoriesList(
                      activeCategoryId: state.activeCategoryId,
                      onCategoryTap: (categoryId) {
                        context.read<MyQrCodesBloc>().add(
                          MyQrCodesCategoryChanged(categoryId),
                        );
                      },
                    ),
                  ),
                if (state.qrCodes.isEmpty)
                  SliverFillRemaining(
                    child: Center(
                      child: Text(
                        'No QR codes yet',
                        style: AppFonts.titleMedium.copyWith(
                          color: AppColors.greyTextColor,
                        ),
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 16,
                      bottom: 160,
                    ),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                            childAspectRatio: 0.7,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final qrCode = state.qrCodes[index];
                        return QrCodeCard(
                          qrCode: qrCode,
                          onTap: () {
                            final bloc = context.read<MyQrCodesBloc>();
                            context.push(
                              '/qr_code_view',
                              extra: {
                                'qrCode': qrCode,
                                'bloc': bloc,
                              },
                            );
                          },
                          onShare: () async {
                            try {
                              await Share.share(qrCode.rawData);
                            } catch (_) {
                              // ignore
                            }
                          },
                          onEdit: () {
                            context.push(
                              '/create_qr_code',
                              extra: {'qrCode': qrCode},
                            );
                          },
                          onDelete: () {
                            _showDeleteDialog(context, qrCode.id);
                          },
                        );
                      }, childCount: state.qrCodes.length),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, String id) {
    CustomDialog.show(
      context: context,
      title: 'Delete QR Code',
      message: 'Are you sure you want to delete this QR code?',
      confirmText: 'Delete',
      cancelText: 'Cancel',
      isDestructive: true,
      onConfirm: () {
        context.read<MyQrCodesBloc>().add(MyQrCodesItemDeleted(id));
      },
    );
  }
}
