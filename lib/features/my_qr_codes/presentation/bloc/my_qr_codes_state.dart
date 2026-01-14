import 'package:equatable/equatable.dart';
import '../../domain/models/created_qr_code_model.dart';

class MyQrCodesState extends Equatable {
  final List<CreatedQrCodeModel> qrCodes;
  final String activeCategoryId;
  final String? searchQuery;
  final bool isLoading;
  final String? errorMessage;

  const MyQrCodesState({
    this.qrCodes = const [],
    this.activeCategoryId = 'all',
    this.searchQuery,
    this.isLoading = false,
    this.errorMessage,
  });

  MyQrCodesState copyWith({
    List<CreatedQrCodeModel>? qrCodes,
    String? activeCategoryId,
    String? searchQuery,
    bool? isLoading,
    String? errorMessage,
  }) {
    return MyQrCodesState(
      qrCodes: qrCodes ?? this.qrCodes,
      activeCategoryId: activeCategoryId ?? this.activeCategoryId,
      searchQuery: searchQuery ?? this.searchQuery,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        qrCodes,
        activeCategoryId,
        searchQuery,
        isLoading,
        errorMessage,
      ];
}
