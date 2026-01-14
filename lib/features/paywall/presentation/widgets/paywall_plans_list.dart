import 'package:flutter/material.dart';
import 'package:qr_scanner/features/paywall/data/models/plan_model.dart';
import 'package:qr_scanner/features/paywall/presentation/widgets/plan_card.dart';

class PaywallPlansList extends StatelessWidget {
  const PaywallPlansList({
    super.key,
    required this.plans,
    required this.selectedPlanId,
    required this.onPlanTap,
  });

  final List<PlanModel> plans;
  final String selectedPlanId;
  final ValueChanged<String> onPlanTap;

  @override
  Widget build(BuildContext context) {
    if (plans.isEmpty) {
      return const SliverToBoxAdapter(
        child: SizedBox.shrink(),
      );
    }

    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final plan = plans[index];
          return Padding(
            padding: EdgeInsets.only(
              bottom: index < plans.length - 1 ? 12 : 0,
            ),
            child: PlanCard(
              plan: plan,
              isSelected: selectedPlanId == plan.id,
              onTap: () => onPlanTap(plan.id),
            ),
          );
        },
        childCount: plans.length,
      ),
    );
  }
}
