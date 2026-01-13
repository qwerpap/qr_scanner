import 'package:flutter/material.dart';
import 'package:qr_scanner/features/paywall/data/constants/plans_data.dart';
import 'package:qr_scanner/features/paywall/presentation/widgets/plan_card.dart';

class PaywallPlansList extends StatelessWidget {
  const PaywallPlansList({
    super.key,
    required this.selectedPlanId,
    required this.onPlanTap,
  });

  final String selectedPlanId;
  final ValueChanged<String> onPlanTap;

  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final plan = PlansData.plans[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < PlansData.plans.length - 1 ? 12 : 0,
            ),
            child: PlanCard(
              plan: plan,
              isSelected: selectedPlanId == plan.id,
              onTap: () => onPlanTap(plan.id),
            ),
          );
        },
        childCount: PlansData.plans.length,
      ),
    );
  }
}
