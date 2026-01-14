import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_scanner/core/bloc/bloc_providers.dart';
import 'package:qr_scanner/core/l10n/app_localizations_helper.dart';
import 'package:qr_scanner/core/shared/widgets/base_container.dart';
import 'package:qr_scanner/core/shared/widgets/custom_sliver_app_bar.dart';
import 'package:qr_scanner/core/shared/widgets/qr_code_section.dart';
import 'package:qr_scanner/core/core.dart';
import 'package:qr_scanner/features/scan_qr/data/constants/control_buttons_data.dart';
import 'package:qr_scanner/features/scan_qr/presentation/cubit/qr_scanner_cubit.dart';
import 'package:qr_scanner/features/scan_qr/presentation/widgets/control_buttons_list.dart';
import 'package:qr_scanner/features/scan_qr/presentation/widgets/scan_info_card.dart';

class ScanQrScreen extends StatefulWidget {
  const ScanQrScreen({super.key});

  @override
  State<ScanQrScreen> createState() => _ScanQrScreenState();
}

class _ScanQrScreenState extends State<ScanQrScreen> {
  bool _permissionRequested = false;
  PermissionStatus? _permissionStatus;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<QrScannerCubit>(),
      child: Builder(
        builder: (blocContext) {
          final qrState = blocContext.watch<QrScannerCubit>().state;
          if (!_permissionRequested) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) {
                _ensurePermissionsRequested(blocContext);
              }
            });
          }
          return Scaffold(
            body: CustomScrollView(
              slivers: [
                CustomSliverAppBar(
                  title: context.l10n.scanQrCode,
                  showDivider: false,
                  showCloseButton: true,
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: 20),
                      const ScanInfoCard(),
                      const SizedBox(height: 40),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: qrState.isCheckingPermission
                            ? const Center(child: CircularProgressIndicator())
                            : QrCodeSection(
                                hasPermission: qrState.hasPermission,
                                onPermissionRequest: () {
                                  if (_permissionStatus ==
                                      PermissionStatus.permanentlyDenied) {
                                    openAppSettings();
                                  } else {
                                    blocContext
                                        .read<QrScannerCubit>()
                                        .requestCameraPermission();
                                  }
                                },
                              ),
                      ),
                      const SizedBox(height: 40),
                      BaseContainer(
                        padding: const EdgeInsets.all(16),
                        child: ControlButtonsList(
                          buttons: ControlButtonsData.getButtons(
                            context: context,
                            onFlashTap: () {
                              if (qrState.hasPermission &&
                                  _permissionStatus !=
                                      PermissionStatus.permanentlyDenied &&
                                  !qrState.isIOSSimulator) {
                                blocContext
                                    .read<QrScannerCubit>()
                                    .toggleFlash();
                              }
                            },
                            onSwitchTap: () {
                              if (qrState.hasPermission &&
                                  _permissionStatus !=
                                      PermissionStatus.permanentlyDenied &&
                                  !qrState.isIOSSimulator) {
                                blocContext
                                    .read<QrScannerCubit>()
                                    .switchCamera();
                              }
                            },
                            onGalleryTap: () {
                              _handleGalleryTap(blocContext, qrState);
                            },
                            isFlashActive: qrState.isFlashOn,
                            isSwitchActive:
                                qrState.currentFacing == CameraFacing.front,
                            isGalleryActive: qrState.isPickingImage,
                          ),
                        ),
                      ),
                    ]),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _ensurePermissionsRequested(BuildContext blocContext) async {
    _permissionRequested = true;
    await blocContext.read<QrScannerCubit>().requestCameraPermission();
    final status = await Permission.camera.status;
    if (mounted) {
      setState(() {
        _permissionStatus = status;
      });
    }
  }

  Future<void> _handleGalleryTap(
    BuildContext blocContext,
    dynamic qrState,
  ) async {
    // На iOS симуляторе и Android - просто вызываем pickImageFromGallery
    // Логика разрешений уже обработана в cubit
    blocContext.read<QrScannerCubit>().pickImageFromGallery();
  }
}
