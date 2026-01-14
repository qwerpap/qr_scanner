import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner/core/bloc/bloc_providers.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';
import 'package:qr_scanner/features/home/data/constants/action_cards_data.dart';
import 'package:qr_scanner/features/home/presentation/cubit/home_cubit.dart';
import 'package:qr_scanner/features/home/presentation/cubit/home_state.dart';
import 'package:qr_scanner/features/home/presentation/widgets/action_card.dart';
import 'package:qr_scanner/features/home/presentation/widgets/recent_card.dart';
import 'package:qr_scanner/features/home/presentation/widgets/welcome_text.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _getRouteForActionCard(String title, BuildContext context) {
    if (title == context.l10n.scanQr) {
      return NavigationConstants.scanQr;
    } else if (title == context.l10n.createQr) {
      return '/create_qr_code';
    } else if (title == context.l10n.myQrCodesTitle) {
      return NavigationConstants.myQrCodes;
    } else if (title == context.l10n.historyTitle) {
      return NavigationConstants.history;
    }
    return NavigationConstants.home;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<HomeCubit>(),
      child: _HomeScreenContent(
        onRouteForActionCard: _getRouteForActionCard,
      ),
    );
  }
}

class _HomeScreenContent extends StatefulWidget {
  final String Function(String, BuildContext) onRouteForActionCard;

  const _HomeScreenContent({
    required this.onRouteForActionCard,
  });

  @override
  State<_HomeScreenContent> createState() => _HomeScreenContentState();
}

class _HomeScreenContentState extends State<_HomeScreenContent> {
  bool _hasInitialized = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (context, state) {
        // Listener for state changes
      },
      builder: (context, state) {
        // Initialize on first build
        if (!_hasInitialized) {
          _hasInitialized = true;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && !state.isLoading) {
              context.read<HomeCubit>().initialize(localizations: context.l10n);
            }
          });
        }

        return Scaffold(
          body: SafeArea(
            child: _buildContent(context, state),
          ),
        );
      },
    );
  }

  Widget _buildContent(BuildContext context, HomeState state) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

              if (state.errorMessage != null &&
                  state.recentActivities.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('${context.l10n.error}: ${state.errorMessage}'),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context.read<HomeCubit>().refresh(localizations: context.l10n),
                        child: Text(context.l10n.retryButton),
                      ),
                    ],
                  ),
                );
              }

              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.all(24),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([const WelcomeText()]),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    sliver: SliverGrid(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.88,
                            mainAxisSpacing: 16,
                            crossAxisSpacing: 16,
                          ),
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final cards = ActionCardsData.getCards(context);
                        final card = cards[index];
                        return ActionCard(
                          model: card,
                          onTap: () {
                            final route = widget.onRouteForActionCard(card.title, context);
                            context.push(route);
                          },
                        );
                      }, childCount: ActionCardsData.getCards(context).length),
                    ),
                  ),
                  if (state.recentActivities.isNotEmpty)
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
                                  context.l10n.recentActivity,
                                  style: AppFonts.displayMedium.copyWith(
                                    fontSize: 22,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                RecentCard(
                                  model: state.recentActivities[0],
                                  onPressed: () {
                                    if (state.recentActivities[0].qrData !=
                                        null) {
                                      context.push(
                                        '/scan_result',
                                        extra: {
                                          'qrData':
                                              state.recentActivities[0].qrData,
                                        },
                                      );
                                    }
                                  },
                                ),
                              ],
                            );
                          }
                          return Padding(
                            padding: const EdgeInsets.only(top: 12),
                            child: RecentCard(
                              model: state.recentActivities[index],
                              onPressed: () {
                                if (state.recentActivities[index].qrData !=
                                    null) {
                                  context.push(
                                    '/scan_result',
                                    extra: {
                                      'qrData':
                                          state.recentActivities[index].qrData,
                                    },
                                  );
                                }
                              },
                            ),
                          );
                        }, childCount: state.recentActivities.length),
                      ),
                    ),
                ],
              );
  }
}
