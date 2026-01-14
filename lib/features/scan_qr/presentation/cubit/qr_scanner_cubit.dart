import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:qr_scanner/core/bloc/bloc_providers.dart';
import 'package:qr_scanner/core/services/app_side_effect.dart';
import 'package:qr_scanner/core/services/app_side_effect_controller.dart';
import 'package:qr_scanner/core/services/notification_type.dart';
import 'qr_scanner_state.dart';

class QrScannerCubit extends Cubit<QrScannerState> {
  final Talker _talker = getIt<Talker>();
  final ImagePicker _imagePicker = ImagePicker();
  final AppSideEffectController _sideEffectController = getIt<AppSideEffectController>();

  QrScannerCubit() : super(const QrScannerState()) {
    _checkIOSSimulator();
  }

  Future<void> _checkIOSSimulator() async {
    if (Platform.isIOS && !kIsWeb) {
      try {
        final result = await Process.run('xcrun', [
          'simctl',
          'list',
          'devices',
          'booted',
        ]);
        final isSimulator =
            result.exitCode == 0 && result.stdout.toString().isNotEmpty;
        emit(state.copyWith(isIOSSimulator: isSimulator));
      } catch (e) {
        emit(state.copyWith(isIOSSimulator: false));
      }
    }
  }

  Future<void> requestCameraPermission() async {
    emit(state.copyWith(isInitializing: true, isIOSSimulator: state.isIOSSimulator));

    if (kIsWeb) {
      emit(state.copyWith(hasPermission: false, isCheckingPermission: false, isInitializing: false));
      return;
    }

    if (Platform.isIOS && !kIsWeb) {
      try {
        final isSimulator = await _isIOSSimulatorInternal();
        emit(state.copyWith(isIOSSimulator: isSimulator));
        if (isSimulator) {
          emit(state.copyWith(hasPermission: false, isCheckingPermission: false, isInitializing: false));
          return;
        }
      } catch (e) {
        emit(state.copyWith(isIOSSimulator: false));
      }
    }

    try {
      _talker.info('Requesting camera permission');
      final status = await Permission.camera.request();
      _talker.info('Camera permission status: $status');
      final granted = status.isGranted;
      emit(state.copyWith(
        hasPermission: granted,
        isCheckingPermission: false,
        permissionStatus: status,
      ));
      if (granted) {
        await initializeScanner(true);
      }
    } catch (e, stackTrace) {
      _talker.error('Error requesting camera permission', e, stackTrace);
      emit(state.copyWith(
        hasPermission: false,
        isCheckingPermission: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<bool> _isIOSSimulatorInternal() async {
    if (!Platform.isIOS) return false;
    try {
      final result = await Process.run('xcrun', ['simctl', 'list', 'devices', 'booted']);
      return result.exitCode == 0 && result.stdout.toString().isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  Future<void> initializeScanner(bool hasPermission) async {
    if (!hasPermission || state.isIOSSimulator || kIsWeb) {
      return;
    }

    emit(state.copyWith(isInitializing: true));

    try {
      _talker.info('Initializing mobile scanner');
      final controller = MobileScannerController(
        detectionSpeed: DetectionSpeed.noDuplicates,
        facing: state.currentFacing,
        torchEnabled: state.isFlashOn,
        autoStart: true,
      );
      emit(state.copyWith(controller: controller, isInitializing: false));
      _talker.info('MobileScannerController initialized successfully');
    } catch (e, stackTrace) {
      _talker.error('Error initializing scanner', e, stackTrace);
      emit(state.copyWith(isInitializing: false, errorMessage: e.toString()));
    }
  }

  Future<void> startController() async {
    final controller = state.controller;
    if (controller == null) return;
    try {
      await controller.start();
      _talker.info('MobileScannerController started');
    } catch (e, stackTrace) {
      _talker.error('Error starting MobileScannerController', e, stackTrace);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void handleBarcode(BarcodeCapture capture) {
    if (capture.barcodes.isEmpty) return;
    if (state.isProcessingQr) return;

    final barcode = capture.barcodes.first;
    if (barcode.rawValue != null && barcode.rawValue!.isNotEmpty) {
      _talker.info('QR code detected: ${barcode.rawValue}');
      emit(state.copyWith(
        detectedQrData: barcode.rawValue,
        isProcessingQr: true,
      ));
    }
  }

  void toggleFlash() {
    if (state.controller == null) return;

    try {
      state.controller!.toggleTorch();
      emit(state.copyWith(isFlashOn: !state.isFlashOn));
      _talker.info('Flash toggled: ${!state.isFlashOn}');
    } catch (e, stackTrace) {
      _talker.error('Error toggling flash', e, stackTrace);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void switchCamera() {
    if (state.controller == null) return;

    try {
      state.controller!.switchCamera();
      final newFacing = state.currentFacing == CameraFacing.back
          ? CameraFacing.front
          : CameraFacing.back;
      emit(state.copyWith(currentFacing: newFacing));
      _talker.info('Camera switched to: $newFacing');
    } catch (e, stackTrace) {
      _talker.error('Error switching camera', e, stackTrace);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> pickImageFromGallery() async {
    if (state.isPickingImage) {
      _talker.warning('Image picker is already active');
      return;
    }

    try {
      emit(state.copyWith(isPickingImage: true));
      
      // Сначала пытаемся открыть image_picker напрямую
      // На iOS симуляторе и некоторых устройствах это может работать без явного запроса разрешения
      _talker.info('Opening gallery picker');
      XFile? image;
      
      try {
        image = await _imagePicker.pickImage(
          source: ImageSource.gallery,
        );
      } catch (pickerError) {
        _talker.warning('Image picker error: $pickerError');
        // Если image_picker выдал ошибку, запрашиваем разрешение явно
        if (Platform.isIOS) {
          _talker.info('Requesting photo library permission explicitly');
      final status = await Permission.photos.request();
          _talker.info('Photo library permission status: $status');
          
          if (status.isGranted || status.isLimited) {
            _talker.info('Retrying gallery picker after permission granted');
            image = await _imagePicker.pickImage(
              source: ImageSource.gallery,
            );
          } else if (status.isPermanentlyDenied) {
            emit(state.copyWith(isPickingImage: false));
            _talker.warning('Photo library permission permanently denied');
            // Пользователь может открыть настройки через системный диалог
            return;
          } else {
        emit(state.copyWith(isPickingImage: false));
        _talker.warning('Photo library permission denied');
        return;
      }
        } else {
          // Android - запрашиваем разрешение
          _talker.info('Requesting storage permission for Android');
          final status = await Permission.storage.request();
          if (status.isGranted) {
            _talker.info('Retrying gallery picker after permission granted');
            image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );
          } else {
            emit(state.copyWith(isPickingImage: false));
            _talker.warning('Storage permission denied');
            return;
          }
        }
      }

      if (image == null) {
        emit(state.copyWith(isPickingImage: false));
        _talker.info('No image selected');
        return;
      }

      _talker.info('Image selected: ${image.path}');
      
      // Проверяем симулятор перед сканированием
      if (Platform.isIOS) {
        final isSimulator = await _isIOSSimulatorInternal();
        if (isSimulator) {
          emit(state.copyWith(isPickingImage: false));
          _talker.warning('Image scanning is not supported on iOS Simulator');
          _sideEffectController.emit(
            const ShowNotificationSideEffect(NotificationType.simulatorNotSupported),
          );
          return;
        }
      }
      
      await _scanImageFromFile(image.path);
      emit(state.copyWith(isPickingImage: false));
    } catch (e, stackTrace) {
      _talker.error('Error picking image from gallery', e, stackTrace);
      emit(state.copyWith(
        isPickingImage: false,
        errorMessage: e.toString(),
      ));
    }
  }

  Future<void> _scanImageFromFile(String imagePath) async {
    // Проверяем, что это iOS симулятор (проверяем напрямую, так как state может быть не актуален)
    if (Platform.isIOS) {
      final isSimulator = await _isIOSSimulatorInternal();
      if (isSimulator) {
        _talker.warning('Image scanning is not supported on iOS Simulator');
        _sideEffectController.emit(
          const ShowNotificationSideEffect(NotificationType.simulatorNotSupported),
        );
        return;
      }
    }

    MobileScannerController? controller = state.controller;
    MobileScannerController? tempController;
    try {
      _talker.info('Scanning QR code from image: $imagePath');
      if (controller == null) {
        tempController = MobileScannerController(autoStart: false);
        controller = tempController;
      }

      final result = await controller.analyzeImage(imagePath);

      if (result != null && result.barcodes.isNotEmpty) {
        final barcode = result.barcodes.first;
        if (barcode.rawValue != null) {
          _talker.info('QR code found in image: ${barcode.rawValue}');
          emit(state.copyWith(detectedQrData: barcode.rawValue));
        } else {
          _talker.warning('QR code found but no data');
          _sideEffectController.emit(
            const ShowNotificationSideEffect(NotificationType.noQrFound),
          );
        }
      } else {
        _talker.warning('No QR code found in image');
        _sideEffectController.emit(
          const ShowNotificationSideEffect(NotificationType.noQrFound),
        );
      }
    } catch (e, stackTrace) {
      _talker.error('Error scanning image', e, stackTrace);
      
      // Обрабатываем специфичную ошибку iOS симулятора
      final errorMessage = e.toString().toLowerCase();
      if (errorMessage.contains('simulator') || 
          errorMessage.contains('not supported') ||
          errorMessage.contains('unsupported operation')) {
        _talker.warning('Image scanning is not supported on iOS Simulator');
        _sideEffectController.emit(
          const ShowNotificationSideEffect(NotificationType.simulatorNotSupported),
        );
      } else {
      emit(state.copyWith(errorMessage: e.toString()));
        _sideEffectController.emit(
          const ShowNotificationSideEffect(NotificationType.noQrFound),
        );
      }
    } finally {
      if (tempController != null) {
        try {
          await tempController.dispose();
        } catch (_) {}
      }
    }
  }

  void clearDetectedQrData() {
    emit(state.copyWith(
      detectedQrData: null,
      isProcessingQr: false,
    ));
  }

  @override
  Future<void> close() {
    state.controller?.stop();
    state.controller?.dispose();
    return super.close();
  }
}
