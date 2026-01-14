import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_scanner/core/shared/widgets/custom_elevated_button.dart';
import 'package:qr_scanner/core/theme/app_colors.dart';
import 'package:qr_scanner/core/theme/app_fonts.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';
import 'package:qr_scanner/features/scan_qr/presentation/cubit/qr_scanner_cubit.dart';
import 'package:qr_scanner/features/scan_qr/presentation/cubit/qr_scanner_state.dart';

class QrCodeSection extends StatefulWidget {
  final bool hasPermission;
  final VoidCallback? onPermissionRequest;

  const QrCodeSection({
    super.key,
    required this.hasPermission,
    this.onPermissionRequest,
  });

  @override
  State<QrCodeSection> createState() => _QrCodeSectionState();
}

class _QrCodeSectionState extends State<QrCodeSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final cubit = context.read<QrScannerCubit>();
      final state = cubit.state;
      if (widget.hasPermission &&
          !state.isIOSSimulator &&
          state.controller == null) {
        cubit.initializeScanner(widget.hasPermission);
      }
    });
  }

  @override
  void didUpdateWidget(QrCodeSection oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.hasPermission && !oldWidget.hasPermission) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (!mounted) return;
        final cubit = context.read<QrScannerCubit>();
        final state = cubit.state;
        if (!state.isIOSSimulator && state.controller == null) {
          cubit.initializeScanner(widget.hasPermission);
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<QrScannerCubit, QrScannerState>(
      listener: (context, state) {
        if (state.detectedQrData != null) {
          context.read<QrScannerCubit>().clearDetectedQrData();
          context.go('/scan_result', extra: {'qrData': state.detectedQrData});
        }
      },
      child: BlocBuilder<QrScannerCubit, QrScannerState>(
        builder: (context, state) {
          final shouldShowPlaceholder = 
              state.showPlaceholder || 
              !widget.hasPermission || 
              state.controller == null;

          return LayoutBuilder(
            builder: (context, constraints) {
              if (shouldShowPlaceholder) {
                return SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: _buildPlaceholder(state),
                );
              }

              return SizedBox.expand(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primaryColor, width: 2),
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.whiteColor,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryColor.withOpacity(0.3),
                        blurRadius: 40,
                        spreadRadius: 0,
                        offset: const Offset(0, 0),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(14),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        MobileScanner(
                          controller: state.controller!,
                          onDetect: (capture) {
                            final cubit = context.read<QrScannerCubit>();
                            cubit.handleBarcode(capture);
                          },
                        ),
                        AnimatedBuilder(
                          animation: _animation,
                          builder: (context, child) {
                            final position =
                                _animation.value * constraints.maxHeight;
                            return Positioned(
                              top: position,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 2.5,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: [
                                      const Color.fromRGBO(0, 0, 0, 0),
                                      AppColors.primaryColor,
                                      const Color.fromRGBO(0, 0, 0, 0),
                                    ],
                                    stops: const [0.0, 0.5, 1.0],
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPlaceholder(QrScannerState state) {
    final isPermanentlyDenied = state.isPermissionPermanentlyDenied;
    final isDenied = state.isPermissionDenied && !isPermanentlyDenied;
    final isIOSSimulator = state.isIOSSimulator;
    final showPermissionButton =
        !widget.hasPermission &&
        !isIOSSimulator &&
        widget.onPermissionRequest != null &&
        (isDenied || isPermanentlyDenied);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.primaryColor, width: 2),
        borderRadius: BorderRadius.circular(16),
        color: AppColors.whiteColor,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.3),
            blurRadius: 40,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
        children: [
          Center(
                child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                children: [
                        // Красивая иконка для iOS симулятора
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.primaryGradient,
                          ),
                          child: Icon(
                            isIOSSimulator
                                ? Icons.phone_iphone
                                : Icons.qr_code_scanner,
                            size: 40,
                            color: AppColors.whiteColor,
                          ),
                        ),
                        const SizedBox(height: 24),
                      Text(
                        _getPlaceholderTitle(context, state, isPermanentlyDenied),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.blackColor,
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _getPlaceholderText(context, state, isPermanentlyDenied),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                    color: AppColors.greyTextColor,
                          fontSize: 14,
                        ),
                  ),
                        if (isIOSSimulator) ...[
                  const SizedBox(height: 16),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              context.l10n.useGalleryButtonToScan,
                    textAlign: TextAlign.center,
                              style: TextStyle(
                                color: AppColors.primaryDarkColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                    ),
                  ),
                        ],
                  if (showPermissionButton) ...[
                    const SizedBox(height: 24),
                          CustomElevatedButton(
                      onPressed: isPermanentlyDenied
                          ? () async {
                              await openAppSettings();
                            }
                          : widget.onPermissionRequest,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isPermanentlyDenied
                                      ? Icons.settings
                                      : Icons.lock_open,
                                  size: 20,
                                  color: AppColors.whiteColor,
                      ),
                                const SizedBox(width: 8),
                              Text(
                        isPermanentlyDenied
                                    ? context.l10n.openSettings
                                    : context.l10n.requestPermission,
                                style: AppFonts.titleLarge.copyWith(
                                  color: AppColors.whiteColor,
                                ),
                        ),
                              ],
                      ),
                    ),
                    if (isPermanentlyDenied) ...[
                      const SizedBox(height: 12),
                          Text(
                            context.l10n.pleaseEnableCameraPermission,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.greyTextColor,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ),
              ),
              // Анимированная линия сканирования
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  final position = _animation.value * constraints.maxHeight;
                  return Positioned(
                    top: position,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 2.5,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            const Color.fromRGBO(0, 0, 0, 0),
                            AppColors.primaryColor,
                            const Color.fromRGBO(0, 0, 0, 0),
                          ],
                          stops: const [0.0, 0.5, 1.0],
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
              );
            },
      ),
    );
  }

  String _getPlaceholderTitle(BuildContext context, QrScannerState state, bool isPermanentlyDenied) {
    if (state.isIOSSimulator) {
      return context.l10n.cameraUnavailable;
    }
    if (isPermanentlyDenied) {
      return context.l10n.cameraAccessDenied;
    }
    if (state.isPermissionDenied) {
      return context.l10n.cameraPermissionRequired;
    }
    return context.l10n.initializingCameraTitle;
  }

  String _getPlaceholderText(BuildContext context, QrScannerState state, bool isPermanentlyDenied) {
    if (state.isIOSSimulator) {
      return context.l10n.cameraNotAvailableOnSimulator;
    }
    if (isPermanentlyDenied) {
      return context.l10n.cameraPermissionDenied;
    }
    if (state.isPermissionDenied) {
      return context.l10n.cameraPermissionRequiredToScan;
    }
    if (state.isInitializing) {
      return context.l10n.initializingCamera;
    }
    if (!widget.hasPermission) {
      return context.l10n.cameraPermissionRequiredText;
    }
    return context.l10n.loadingCamera;
  }
}
