import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/features/paywall/data/constants/plans_data.dart';
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
  String _selectedPlanId = PlansData.plans[1].id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBgColor,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: const PaywallGradientSection()),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([const SizedBox(height: 30)]),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: const PaywallFeaturesList(),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([const SizedBox(height: 32)]),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: PaywallPlansList(
                selectedPlanId: _selectedPlanId,
                onPlanTap: (planId) {
                  setState(() {
                    _selectedPlanId = planId;
                  });
                },
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverToBoxAdapter(child: const PaywallFooter()),
            ),
          ],
        ),
      ),
    );
  }
}
