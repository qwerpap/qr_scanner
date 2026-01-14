import 'package:flutter/material.dart';
import '../../../../core/l10n/app_localizations_helper.dart';
import '../../../../core/subscription/subscription_product.dart';
import '../models/plan_model.dart';

/// Маппер для преобразования SubscriptionProduct в PlanModel для UI.
class SubscriptionProductToPlanMapper {
  /// Преобразует SubscriptionProduct в PlanModel.
  static PlanModel map(SubscriptionProduct product, BuildContext context) {
    // Определяем период и описание на основе product ID
    String period;
    String description;
    String? badgeText;
    BadgePosition? badgePosition;
    String? originalPrice;
    String? savingsText;

    switch (product.id) {
      case 'sonicforge_weekly':
        period = '/ ${context.l10n.week}';
        description = context.l10n.threeDayFreeTrial;
        badgeText = context.l10n.mostPopular;
        badgePosition = BadgePosition.topLeft;
        break;
      case 'sonicforge_monthly':
        period = '/ ${context.l10n.month}';
        description = context.l10n.cancelAnytime;
        break;
      case 'sonicforge_yearly':
        period = '/ ${context.l10n.year}';
        description = context.l10n.bestValueOption;
        badgeText = context.l10n.savePercent('70');
        badgePosition = BadgePosition.topRight;
        // Вычисляем оригинальную цену (месячная * 12)
        // Это примерная логика, можно улучшить
        try {
          final currentPrice = double.tryParse(
            product.price.replaceAll(RegExp(r'[^\d.]'), ''),
          );
          if (currentPrice != null) {
            // Предполагаем, что годовая цена должна быть примерно месячная * 12
            // Но реальная годовая цена уже в product.price, поэтому вычисляем экономию
            final estimatedMonthly = currentPrice / 12;
            final estimatedYearly = estimatedMonthly * 12;
            if (estimatedYearly > currentPrice) {
              originalPrice = '${product.currencyCode == 'USD' ? '\$' : product.currencyCode}${estimatedYearly.toStringAsFixed(2)}';
              final savings = estimatedYearly - currentPrice;
              savingsText = '${context.l10n.save} ${product.currencyCode == 'USD' ? '\$' : product.currencyCode}${savings.toStringAsFixed(0)}';
            }
          }
        } catch (_) {
          // Если не удалось вычислить, оставляем null
        }
        break;
      default:
        period = '';
        description = '';
    }

    return PlanModel(
      id: product.id,
      name: product.title,
      price: product.price,
      period: period,
      description: description,
      badgeText: badgeText,
      badgePosition: badgePosition,
      originalPrice: originalPrice,
      savingsText: savingsText,
    );
  }

  /// Преобразует список SubscriptionProduct в список PlanModel.
  static List<PlanModel> mapList(List<SubscriptionProduct> products, BuildContext context) {
    return products.map((product) => map(product, context)).toList();
  }
}
