import 'package:qr_scanner/features/paywall/data/models/plan_model.dart';

class PlansData {
  static const List<PlanModel> plans = [
    PlanModel(
      id: 'weekly',
      name: 'Weekly Plan',
      price: '\$3.99',
      period: '/ week',
      description: '3-day free trial',
      badgeText: 'MOST POPULAR',
      badgePosition: BadgePosition.topLeft,
    ),
    PlanModel(
      id: 'monthly',
      name: 'Monthly Plan',
      price: '\$7.99',
      period: '/ month',
      description: 'Cancel anytime',
    ),
    PlanModel(
      id: 'yearly',
      name: 'Yearly Plan',
      price: '\$29.99',
      period: '/ year',
      description: 'Best value option',
      badgeText: 'SAVE 70%',
      badgePosition: BadgePosition.topRight,
      originalPrice: '\$99.99',
      savingsText: 'Save \$70',
    ),
  ];
}
