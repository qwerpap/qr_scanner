import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_scanner/features/create_qr/presentation/cubit/create_qr_code_cubit.dart';
import 'package:qr_scanner/features/create_qr/presentation/view/create_qr_code_screen.dart';
import 'package:qr_scanner/features/create_qr/presentation/view/qr_code_ready_screen.dart';
import 'package:qr_scanner/features/my_qr_codes/domain/models/created_qr_code_model.dart';
import 'package:qr_scanner/features/my_qr_codes/presentation/view/qr_code_view_screen.dart';
import 'package:qr_scanner/features/onboarding/presentation/view/onboarding_screen.dart';
import 'package:qr_scanner/features/paywall/presentation/view/paywall_screen.dart';
import 'package:qr_scanner/features/scan_result/presentation/view/scan_result_screen.dart';
import 'package:qr_scanner/features/scan_result/presentation/view/notification_handler.dart';
import 'package:qr_scanner/features/splash/presentation/view/splash_screen.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../bloc/bloc_providers.dart';
import '../../data/constants/navigation_constants.dart';
import '../../data/utils/page_transitions.dart';
import '../cubit/navigation_cubit.dart';
import '../utils/navigation_utils.dart';
import 'bottom_navigation.dart';
import '../../../../features/home/presentation/view/home_screen.dart';
import '../../../../features/scan_qr/presentation/view/scan_qr_screen.dart';
import '../../../../features/my_qr_codes/presentation/view/my_qr_codes_screen.dart';
import '../../../../features/history/presentation/view/history_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/splash',
    observers: [TalkerRouteObserver(getIt<Talker>())],
    routes: [
      GoRoute(
        path: '/splash',
        pageBuilder: (context, state) => PageTransitions.fadeTransition(
          child: const SplashScreen(),
          state: state,
        ),
      ),
      GoRoute(
        path: '/onboarding',
        pageBuilder: (context, state) => PageTransitions.fadeTransition(
          child: const OnboardingScreen(),
          state: state,
          duration: const Duration(milliseconds: 200),
        ),
      ),
      ShellRoute(
        builder: (context, state, child) {
          return MainShell(child: child);
        },
        routes: [
          GoRoute(
            path: NavigationConstants.home,
            pageBuilder: (context, state) => PageTransitions.fadeTransition(
              child: const HomeScreen(),
              state: state,
              duration: const Duration(milliseconds: 200),
            ),
          ),
          GoRoute(
            path: '/my_qr_codes',
            pageBuilder: (context, state) => PageTransitions.fadeTransition(
              child: const MyQrCodesScreen(),
              state: state,
            ),
          ),
          GoRoute(
            path: '/create_qr_code',
            pageBuilder: (context, state) => PageTransitions.slideTransition(
              child: const CreateQrCodeScreen(),
              state: state,
            ),
          ),
          GoRoute(
            path: '/paywall',
            pageBuilder: (context, state) => PageTransitions.fadeTransition(
              child: const PaywallScreen(),
              state: state,
            ),
          ),
          GoRoute(
            path: '/history',
            pageBuilder: (context, state) => PageTransitions.slideTransition(
              child: const HistoryScreen(),
              state: state,
            ),
          ),
          GoRoute(
            path: NavigationConstants.scanQr,
            pageBuilder: (context, state) => PageTransitions.slideTransition(
              child: const ScanQrScreen(),
              state: state,
            ),
          ),
          GoRoute(
            path: NavigationConstants.myQrCodes,
            pageBuilder: (context, state) => PageTransitions.slideTransition(
              child: const MyQrCodesScreen(),
              state: state,
            ),
          ),
          GoRoute(
            path: '/scan_result',
            pageBuilder: (context, state) {
              final qrData = state.extra as Map<String, dynamic>?;
              final qrDataString = qrData?['qrData'] as String? ?? '';
              return PageTransitions.fadeTransition(
                child: ScanResultScreen(qrData: qrDataString),
                state: state,
              );
            },
          ),
          GoRoute(
            path: '/qr_code_view',
            pageBuilder: (context, state) => PageTransitions.slideTransition(
              child: const QrCodeViewScreen(),
              state: state,
            ),
          ),
          GoRoute(
            path: '/qr_code_ready',
            pageBuilder: (context, state) {
              final extra = state.extra;
              
              // If extra is CreateQrCodeCubit, use it directly
              if (extra is CreateQrCodeCubit) {
                return PageTransitions.fadeTransition(
                  child: BlocProvider.value(
                    value: extra,
                    child: const QrCodeReadyScreen(),
                  ),
                  state: state,
                );
              }
              
              // If extra is Map with qrCode, create new cubit and set it
              if (extra is Map<String, dynamic>) {
                final qrCode = extra['qrCode'] as CreatedQrCodeModel?;
                if (qrCode != null) {
                  final cubit = getIt<CreateQrCodeCubit>();
                  cubit.setGeneratedQrCode(qrCode);
                  return PageTransitions.fadeTransition(
                    child: BlocProvider.value(
                      value: cubit,
                      child: const QrCodeReadyScreen(),
                    ),
                    state: state,
                  );
                }
              }
              
              // Fallback: create new cubit without QR code
              return PageTransitions.fadeTransition(
                child: BlocProvider(
                  create: (context) => getIt<CreateQrCodeCubit>(),
                  child: const QrCodeReadyScreen(),
                ),
                state: state,
              );
            },
          ),
          GoRoute(
            path: NavigationConstants.history,
            pageBuilder: (context, state) => PageTransitions.slideTransition(
              child: const HistoryScreen(),
              state: state,
            ),
          ),
        ],
      ),
    ],
  );
}

class MainShell extends StatelessWidget {
  final Widget child;

  const MainShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocProviders.wrapWithProviders(
      context: context,
      child: _NavigationStateUpdater(child: child),
    );
  }
}

class _NavigationStateUpdater extends StatefulWidget {
  final Widget child;

  const _NavigationStateUpdater({required this.child});

  @override
  State<_NavigationStateUpdater> createState() =>
      _NavigationStateUpdaterState();
}

class _NavigationStateUpdaterState extends State<_NavigationStateUpdater> {
  String? _lastLocation;
  Brightness? _lastBrightness;

  void _updateNavigationState() {
    if (!mounted) return;

    final cubit = context.read<NavigationCubit>();
    final routerState = GoRouterState.of(context);
    final newLocation = routerState.uri.path;
    final newBrightness = MediaQuery.platformBrightnessOf(context);
    final newIsDark = newBrightness == Brightness.dark;

    if (_lastLocation != newLocation) {
      // Use post-frame callback to ensure router state is fully updated
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final currentLocation = GoRouterState.of(context).uri.path;
        final newIndex = NavigationUtils.getCurrentIndex(currentLocation);
        // Only update if route is a main navigation tab (not null)
        if (newIndex != null && newIndex != cubit.state.currentIndex) {
          cubit.updateCurrentRoute(currentLocation);
        }
      });
      _lastLocation = newLocation;
    }
    if (_lastBrightness != newBrightness) {
      cubit.updateTheme(newIsDark);
      _lastBrightness = newBrightness;
    }
  }

  void _onRouterChanged() {
    if (mounted) {
      _updateNavigationState();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateNavigationState();
    });
    AppRouter.router.routerDelegate.addListener(_onRouterChanged);
  }

  @override
  void dispose() {
    AppRouter.router.routerDelegate.removeListener(_onRouterChanged);
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final newBrightness = MediaQuery.platformBrightnessOf(context);
    if (_lastBrightness != newBrightness) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _updateNavigationState();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return NotificationHandler(
      child: Scaffold(
        body: widget.child,
        extendBody: true,
        bottomNavigationBar: const CustomBottomNavigation(),
        floatingActionButton: const CustomFloatingActionButton(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }
}
