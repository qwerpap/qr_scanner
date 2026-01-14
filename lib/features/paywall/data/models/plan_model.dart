import 'package:equatable/equatable.dart';

class PlanModel extends Equatable {
  const PlanModel({
    required this.id,
    required this.name,
    required this.price,
    required this.period,
    required this.description,
    this.badgeText,
    this.badgePosition,
    this.originalPrice,
    this.savingsText,
    this.savingsAmount,
  });

  final String id;
  final String name;
  final String price;
  final String period;
  final String description;
  final String? badgeText;
  final BadgePosition? badgePosition;
  final String? originalPrice;
  final String? savingsText;
  final String? savingsAmount;

  @override
  List<Object?> get props => [
        id,
        name,
        price,
        period,
        description,
        badgeText,
        badgePosition,
        originalPrice,
        savingsText,
        savingsAmount,
      ];
}

enum BadgePosition {
  topLeft,
  topRight,
}
