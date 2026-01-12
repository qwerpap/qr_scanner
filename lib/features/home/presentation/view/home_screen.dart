import 'package:flutter/material.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/features/home/data/constants/action_cards_data.dart';
import 'package:qr_scanner/features/home/data/constants/recent_activity_data.dart';
import 'package:qr_scanner/features/home/presentation/widgets/action_card.dart';
import 'package:qr_scanner/features/home/presentation/widgets/recent_card.dart';
import 'package:qr_scanner/features/home/presentation/widgets/welcome_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 48),
          children: [
            WelcomeText(),
            const SizedBox(height: 28),
            GridView.builder(
              itemCount: ActionCardsData.cards.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.88,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemBuilder: (context, index) {
                return ActionCard(
                  model: ActionCardsData.cards[index],
                  onTap: () {
                    // TODO: Add navigation
                  },
                );
              },
            ),
            const SizedBox(height: 32),
            Text(
              'Recent Activity',
              style: AppFonts.displayMedium.copyWith(fontSize: 22),
            ),
            const SizedBox(height: 16),
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: RecentActivityData.activities.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                return RecentCard(
                  model: RecentActivityData.activities[index],
                  onPressed: () {
                    // TODO: Add navigation
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
