import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../my_qr_codes/domain/models/created_qr_code_model.dart';

class CreateQrCodeState extends Equatable {
  final String selectedTypeId;
  final String urlData;
  final String textData;
  final String wifiData;
  final String contactData;
  final Color selectedColor;
  final bool hasLogo;
  final CreatedQrCodeModel? generatedQrCode;
  final bool isGenerating;
  final bool isSaved;
  final String? editingQrCodeId;
  final String? errorMessage;

  const CreateQrCodeState({
    this.selectedTypeId = 'url',
    this.urlData = '',
    this.textData = '',
    this.wifiData = '',
    this.contactData = '',
    this.selectedColor = const Color.fromRGBO(122, 203, 255, 1),
    this.hasLogo = false,
    this.generatedQrCode,
    this.isGenerating = false,
    this.isSaved = false,
    this.editingQrCodeId,
    this.errorMessage,
  });

  CreateQrCodeState copyWith({
    String? selectedTypeId,
    String? urlData,
    String? textData,
    String? wifiData,
    String? contactData,
    Color? selectedColor,
    bool? hasLogo,
    CreatedQrCodeModel? generatedQrCode,
    bool? isGenerating,
    bool? isSaved,
    String? editingQrCodeId,
    String? errorMessage,
  }) {
    return CreateQrCodeState(
      selectedTypeId: selectedTypeId ?? this.selectedTypeId,
      urlData: urlData ?? this.urlData,
      textData: textData ?? this.textData,
      wifiData: wifiData ?? this.wifiData,
      contactData: contactData ?? this.contactData,
      selectedColor: selectedColor ?? this.selectedColor,
      hasLogo: hasLogo ?? this.hasLogo,
      generatedQrCode: generatedQrCode ?? this.generatedQrCode,
      isGenerating: isGenerating ?? this.isGenerating,
      isSaved: isSaved ?? this.isSaved,
      editingQrCodeId: editingQrCodeId ?? this.editingQrCodeId,
      errorMessage: errorMessage,
    );
  }

  String get currentData {
    switch (selectedTypeId) {
      case 'url':
        return urlData;
      case 'text':
        return textData;
      case 'wifi':
        return wifiData;
      case 'contact':
        return textData; // Use textData for contact too
      default:
        return '';
    }
  }

  @override
  List<Object?> get props => [
        selectedTypeId,
        urlData,
        textData,
        wifiData,
        contactData,
        selectedColor,
        hasLogo,
        generatedQrCode,
        isGenerating,
        isSaved,
        editingQrCodeId,
        errorMessage,
      ];
}
