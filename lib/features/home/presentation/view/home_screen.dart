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
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: EdgeInsets.all(24),
              sliver: SliverList(
                delegate: SliverChildListDelegate([WelcomeText()]),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.88,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                delegate: SliverChildBuilderDelegate((context, index) {
                  return ActionCard(
                    model: ActionCardsData.cards[index],
                    onTap: () {
                      // TODO: Add navigation
                    },
                  );
                }, childCount: ActionCardsData.cards.length),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                top: 32,
                bottom: 48,
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate((context, index) {
                  if (index == 0) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recent Activity',
                          style: AppFonts.displayMedium.copyWith(fontSize: 22),
                        ),
                        const SizedBox(height: 16),
                        RecentCard(
                          model: RecentActivityData.activities[0],
                          onPressed: () {
                            // TODO: Add navigation
                          },
                        ),
                      ],
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: RecentCard(
                      model: RecentActivityData.activities[index],
                      onPressed: () {
                        // TODO: Add navigation
                      },
                    ),
                  );
                }, childCount: RecentActivityData.activities.length),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
