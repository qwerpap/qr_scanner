import 'package:equatable/equatable.dart';
import '../../domain/entities/qr_code_type.dart';

class ScanResultState extends Equatable {
  final QrCodeData? qrCodeData;
  final bool isLoading;
  final bool isSaving;
  final String? errorMessage;
  final bool isCopied;
  final bool isLinkOpened;
  final bool isSaved;

  const ScanResultState({
    this.qrCodeData,
    this.isLoading = true,
    this.isSaving = false,
    this.errorMessage,
    this.isCopied = false,
    this.isLinkOpened = false,
    this.isSaved = false,
  });

  ScanResultState copyWith({
    QrCodeData? qrCodeData,
    bool? isLoading,
    bool? isSaving,
    String? errorMessage,
    bool? isCopied,
    bool? isLinkOpened,
    bool? isSaved,
  }) {
    return ScanResultState(
      qrCodeData: qrCodeData ?? this.qrCodeData,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage,
      isCopied: isCopied ?? this.isCopied,
      isLinkOpened: isLinkOpened ?? this.isLinkOpened,
      isSaved: isSaved ?? this.isSaved,
    );
  }

  @override
  List<Object?> get props => [
        qrCodeData,
        isLoading,
        isSaving,
        errorMessage,
        isCopied,
        isLinkOpened,
        isSaved,
      ];
}
