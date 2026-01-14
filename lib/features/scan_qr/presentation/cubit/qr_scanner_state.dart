import 'package:equatable/equatable.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';

class QrScannerState extends Equatable {
  final MobileScannerController? controller;
  final bool isFlashOn;
  final CameraFacing currentFacing;
  final bool hasPermission;
  final bool isCheckingPermission;
  final PermissionStatus? permissionStatus;
  final bool isIOSSimulator;
  final bool isInitializing;
  final bool isProcessingQr;
  final bool isPickingImage;
  final String? errorMessage;
  final String? detectedQrData;

  const QrScannerState({
    this.controller,
    this.isFlashOn = false,
    this.currentFacing = CameraFacing.back,
    this.hasPermission = false,
    this.isCheckingPermission = true,
    this.permissionStatus,
    this.isIOSSimulator = false,
    this.isInitializing = false,
    this.isProcessingQr = false,
    this.isPickingImage = false,
    this.errorMessage,
    this.detectedQrData,
  });

  bool get isReady =>
      controller != null && !isInitializing && errorMessage == null;
  bool get showPlaceholder =>
      controller == null || isIOSSimulator || errorMessage != null;

  QrScannerState copyWith({
    MobileScannerController? controller,
    bool? isFlashOn,
    CameraFacing? currentFacing,
    bool? hasPermission,
    bool? isCheckingPermission,
    PermissionStatus? permissionStatus,
    bool? isIOSSimulator,
    bool? isInitializing,
    bool? isProcessingQr,
    bool? isPickingImage,
    String? errorMessage,
    String? detectedQrData,
  }) {
    return QrScannerState(
      controller: controller ?? this.controller,
      isFlashOn: isFlashOn ?? this.isFlashOn,
      currentFacing: currentFacing ?? this.currentFacing,
      hasPermission: hasPermission ?? this.hasPermission,
      isCheckingPermission: isCheckingPermission ?? this.isCheckingPermission,
      permissionStatus: permissionStatus ?? this.permissionStatus,
      isIOSSimulator: isIOSSimulator ?? this.isIOSSimulator,
      isInitializing: isInitializing ?? this.isInitializing,
      isProcessingQr: isProcessingQr ?? this.isProcessingQr,
      isPickingImage: isPickingImage ?? this.isPickingImage,
      errorMessage: errorMessage,
      detectedQrData: detectedQrData,
    );
  }

  bool get isPermissionDenied => permissionStatus?.isDenied ?? false;
  bool get isPermissionPermanentlyDenied => permissionStatus?.isPermanentlyDenied ?? false;

  @override
  List<Object?> get props => [
    controller,
    isFlashOn,
    currentFacing,
    hasPermission,
    isCheckingPermission,
    permissionStatus,
    isIOSSimulator,
    isInitializing,
    isProcessingQr,
    isPickingImage,
    errorMessage,
    detectedQrData,
  ];
}
