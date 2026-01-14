import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../../core/bloc/bloc_providers.dart';
import '../../../my_qr_codes/domain/models/created_qr_code_model.dart';
import '../../../my_qr_codes/domain/usecases/save_created_qr_code_usecase.dart';
import '../../../my_qr_codes/domain/usecases/update_created_qr_code_usecase.dart';
import '../../../scan_result/domain/entities/qr_code_type.dart';
import '../../domain/models/qr_code_creation_data.dart';
import '../../domain/usecases/generate_qr_code_usecase.dart';
import '../../domain/usecases/validate_qr_code_data_usecase.dart';
import 'create_qr_code_state.dart';

class CreateQrCodeCubit extends Cubit<CreateQrCodeState> {
  final GenerateQrCodeUseCase _generateQrCodeUseCase;
  final ValidateQrCodeDataUseCase _validateQrCodeDataUseCase;
  final SaveCreatedQrCodeUseCase _saveCreatedQrCodeUseCase;
  final UpdateCreatedQrCodeUseCase _updateCreatedQrCodeUseCase;
  final Talker _talker = getIt<Talker>();
  final ImagePicker _imagePicker = ImagePicker();

  CreateQrCodeCubit({
    required GenerateQrCodeUseCase generateQrCodeUseCase,
    required ValidateQrCodeDataUseCase validateQrCodeDataUseCase,
    required SaveCreatedQrCodeUseCase saveCreatedQrCodeUseCase,
    required UpdateCreatedQrCodeUseCase updateCreatedQrCodeUseCase,
  })  : _generateQrCodeUseCase = generateQrCodeUseCase,
        _validateQrCodeDataUseCase = validateQrCodeDataUseCase,
        _saveCreatedQrCodeUseCase = saveCreatedQrCodeUseCase,
        _updateCreatedQrCodeUseCase = updateCreatedQrCodeUseCase,
        super(const CreateQrCodeState());

  void changeContentType(String typeId) {
    emit(state.copyWith(selectedTypeId: typeId));
    _talker.info('Content type changed to: $typeId');
  }

  void updateUrlData(String url) {
    emit(state.copyWith(urlData: url));
  }

  void updateTextData(String text) {
    emit(state.copyWith(textData: text));
  }

  void updateWifiData(String wifiData) {
    emit(state.copyWith(wifiData: wifiData));
  }

  void updateContactData(String contactData) {
    emit(state.copyWith(contactData: contactData));
  }

  void changeColor(Color color) {
    emit(state.copyWith(selectedColor: color));
    _talker.info('Color changed');
  }

  void toggleLogo() {
    emit(state.copyWith(hasLogo: !state.hasLogo));
    _talker.info('Logo toggled: ${!state.hasLogo}');
  }

  Future<void> generateQrCode() async {
    if (state.currentData.trim().isEmpty) {
      emit(state.copyWith(
        errorMessage: 'Please enter data for QR code',
      ));
      return;
    }

    final creationData = QrCodeCreationData(
      contentType: state.selectedTypeId,
      data: state.currentData,
      color: state.selectedColor,
      hasLogo: state.hasLogo,
    );

    if (!_validateQrCodeDataUseCase.execute(creationData)) {
      emit(state.copyWith(
        errorMessage: 'Invalid data for ${state.selectedTypeId}',
      ));
      return;
    }

    emit(state.copyWith(errorMessage: null));
    
    try {
      _talker.info('Generating QR code for type: ${state.selectedTypeId}');
      final qrCode = _generateQrCodeUseCase.execute(creationData);
      
      // Create QR code with logoPath from state
      final qrCodeWithLogo = CreatedQrCodeModel(
        id: qrCode.id,
        rawData: qrCode.rawData,
        type: qrCode.type,
        createdAt: qrCode.createdAt,
        title: qrCode.title,
        color: qrCode.color,
        hasLogo: state.logoPath != null,
        logoPath: state.logoPath,
        categoryId: qrCode.categoryId,
      );
      
      // If editing, update existing QR code, otherwise save new one
      if (state.editingQrCodeId != null) {
        try {
          final updatedQrCode = CreatedQrCodeModel(
            id: state.editingQrCodeId!,
            rawData: qrCodeWithLogo.rawData,
            type: qrCodeWithLogo.type,
            createdAt: qrCodeWithLogo.createdAt,
            title: qrCodeWithLogo.title,
            color: qrCodeWithLogo.color,
            hasLogo: qrCodeWithLogo.hasLogo,
            logoPath: qrCodeWithLogo.logoPath,
            categoryId: qrCodeWithLogo.categoryId,
          );
          await _updateCreatedQrCodeUseCase.execute(updatedQrCode);
          _talker.info('QR code updated successfully');
          emit(state.copyWith(
            generatedQrCode: updatedQrCode,
            isSaved: true,
          ));
        } catch (updateError, updateStackTrace) {
          _talker.error('Error updating QR code', updateError, updateStackTrace);
          emit(state.copyWith(
            generatedQrCode: qrCodeWithLogo,
            isSaved: false,
          ));
        }
      } else {
        // Automatically save the generated QR code
        try {
          await _saveCreatedQrCodeUseCase(qrCodeWithLogo);
          _talker.info('QR code saved automatically');
          emit(state.copyWith(
            generatedQrCode: qrCodeWithLogo,
            isSaved: true,
          ));
        } catch (saveError, saveStackTrace) {
          _talker.error('Error saving QR code automatically', saveError, saveStackTrace);
          // Still emit the generated QR code even if save failed
          emit(state.copyWith(
            generatedQrCode: qrCodeWithLogo,
            isSaved: false,
          ));
        }
      }
      
      _talker.info('QR code generated successfully');
    } catch (e, stackTrace) {
      _talker.error('Error generating QR code', e, stackTrace);
      emit(state.copyWith(
        errorMessage: e.toString(),
      ));
    }
  }

  void clearGeneratedQrCode() {
    emit(state.copyWith(generatedQrCode: null));
  }

  void setGeneratedQrCode(CreatedQrCodeModel qrCode) {
    emit(state.copyWith(generatedQrCode: qrCode, isSaved: true));
    _talker.info('QR code set from existing model');
  }

  void markAsSaved() {
    emit(state.copyWith(isSaved: true));
    _talker.info('QR code marked as saved');
  }

  void initializeForEditing(CreatedQrCodeModel qrCode) {
    // Extract data from rawData based on type
    String urlData = '';
    String textData = '';
    String wifiData = '';
    String contactData = '';
    String typeId = 'text';

    switch (qrCode.type) {
      case QrCodeType.url:
        typeId = 'url';
        urlData = qrCode.rawData.replaceFirst(RegExp(r'^https?://'), '');
        break;
      case QrCodeType.text:
        typeId = 'text';
        textData = qrCode.rawData;
        break;
      case QrCodeType.wifi:
        typeId = 'wifi';
        wifiData = qrCode.rawData;
        break;
      case QrCodeType.vcard:
        typeId = 'contact';
        // Extract name from vCard
        final nameMatch = RegExp(r'FN:(.+)').firstMatch(qrCode.rawData);
        contactData = nameMatch?.group(1) ?? '';
        break;
      default:
        typeId = 'text';
        textData = qrCode.rawData;
    }

    emit(state.copyWith(
      selectedTypeId: typeId,
      urlData: urlData,
      textData: textData,
      wifiData: wifiData,
      contactData: contactData,
      selectedColor: qrCode.color,
      hasLogo: qrCode.hasLogo,
      logoPath: qrCode.logoPath,
      editingQrCodeId: qrCode.id,
    ));
      _talker.info('Initialized for editing QR code: ${qrCode.id}');
  }

  Future<void> pickImageFromGallery() async {
    try {
      final status = await Permission.photos.request();
      if (!status.isGranted) {
        _talker.warning('Photo library permission denied');
        emit(state.copyWith(errorMessage: 'Photo library permission denied'));
        return;
      }

      _talker.info('Picking image from gallery');
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
      );

      if (image == null) {
        _talker.info('No image selected');
        return;
      }

      _talker.info('Image selected: ${image.path}');
      emit(state.copyWith(
        logoPath: image.path,
        hasLogo: true,
      ));
    } catch (e, stackTrace) {
      _talker.error('Error picking image from gallery', e, stackTrace);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> pickImageFromCamera() async {
    try {
      final status = await Permission.camera.request();
      if (!status.isGranted) {
        _talker.warning('Camera permission denied');
        emit(state.copyWith(errorMessage: 'Camera permission denied'));
        return;
      }

      _talker.info('Picking image from camera');
      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.camera,
      );

      if (image == null) {
        _talker.info('No image selected');
        return;
      }

      _talker.info('Image selected: ${image.path}');
      emit(state.copyWith(
        logoPath: image.path,
        hasLogo: true,
      ));
    } catch (e, stackTrace) {
      _talker.error('Error picking image from camera', e, stackTrace);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  void removeLogo() {
    emit(state.copyWith(
      logoPath: null,
      hasLogo: false,
    ));
    _talker.info('Logo removed');
  }
}
