import 'package:flutter/material.dart';
import 'package:qr_scanner/core/bloc/bloc_providers.dart';
import 'package:qr_scanner/core/navigation/presentation/widgets/app_router.dart';
import 'package:qr_scanner/core/theme/app_theme.dart';

void main() {
  BlocProviders.setup();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'QR Scanner',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      routerConfig: AppRouter.router,
    );
  }
}
