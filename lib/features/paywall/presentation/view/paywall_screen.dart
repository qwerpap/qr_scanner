import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/subscription/subscription_product.dart';
import 'package:qr_scanner/features/paywall/data/mappers/subscription_product_to_plan_mapper.dart';
import 'package:qr_scanner/features/paywall/presentation/bloc/paywall_bloc.dart';
import 'package:qr_scanner/features/paywall/presentation/bloc/paywall_event.dart';
import 'package:qr_scanner/features/paywall/presentation/bloc/paywall_state.dart';
import 'package:qr_scanner/features/paywall/presentation/widgets/paywall_features_list.dart';
import 'package:qr_scanner/features/paywall/presentation/widgets/paywall_footer.dart';
import 'package:qr_scanner/features/paywall/presentation/widgets/paywall_gradient_section.dart';
import 'package:qr_scanner/features/paywall/presentation/widgets/paywall_plans_list.dart';

class PaywallScreen extends StatefulWidget {
  const PaywallScreen({super.key});

  @override
  State<PaywallScreen> createState() => _PaywallScreenState();
}

class _PaywallScreenState extends State<PaywallScreen> {
  String? _selectedPlanId;
  SubscriptionProduct? _selectedProduct;

  @override
  void initState() {
    super.initState();
    context.read<PaywallBloc>().add(const PaywallLoadProducts());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: SafeArea(
        child: BlocConsumer<PaywallBloc, PaywallState>(
          listener: (context, state) {
            if (state is PaywallPurchaseSuccess) {
              context.pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Subscription purchased successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is PaywallRestoreSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Purchases restored successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
            } else if (state is PaywallError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          builder: (context, state) {
            if (state is PaywallLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PaywallLoaded) {
              // Устанавливаем выбранный план по умолчанию (месячный, если есть)
              if (_selectedPlanId == null && state.products.isNotEmpty) {
                final monthlyProduct = state.products.firstWhere(
                  (p) => p.id == 'sonicforge_monthly',
                  orElse: () => state.products[0],
                );
                _selectedPlanId = monthlyProduct.id;
                _selectedProduct = monthlyProduct;
              }

              final plans = SubscriptionProductToPlanMapper.mapList(
                state.products,
              );

              return CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(child: const PaywallGradientSection()),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: 30),
                      ]),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: const PaywallFeaturesList(),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        const SizedBox(height: 32),
                      ]),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: PaywallPlansList(
                      plans: plans,
                      selectedPlanId: _selectedPlanId ?? '',
                      onPlanTap: (planId) {
                        setState(() {
                          _selectedPlanId = planId;
                          _selectedProduct = state.products.firstWhere(
                            (p) => p.id == planId,
                          );
                        });
                      },
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverToBoxAdapter(
                      child: PaywallFooter(
                        isLoading:
                            state is PaywallPurchasing ||
                            state is PaywallRestoring,
                        onContinue: _selectedProduct != null
                            ? () {
                                context.read<PaywallBloc>().add(
                                  PaywallPurchase(_selectedProduct!),
                                );
                              }
                            : null,
                        onRestore: () {
                          context.read<PaywallBloc>().add(
                            const PaywallRestore(),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              );
            }

            if (state is PaywallError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      state.message,
                      style: AppFonts.titleMedium,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<PaywallBloc>().add(
                          const PaywallLoadProducts(),
                        );
                      },
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              );
            }

            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
