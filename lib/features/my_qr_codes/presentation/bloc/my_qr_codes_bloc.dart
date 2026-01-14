import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../../core/bloc/bloc_providers.dart';
import '../../domain/usecases/delete_created_qr_code_usecase.dart';
import '../../domain/usecases/get_created_qr_codes_usecase.dart';
import '../../domain/usecases/search_created_qr_codes_usecase.dart';
import 'my_qr_codes_event.dart';
import 'my_qr_codes_state.dart';

class MyQrCodesBloc extends Bloc<MyQrCodesEvent, MyQrCodesState> {
  final GetCreatedQrCodesUseCase _getCreatedQrCodesUseCase;
  final SearchCreatedQrCodesUseCase _searchCreatedQrCodesUseCase;
  final DeleteCreatedQrCodeUseCase _deleteCreatedQrCodeUseCase;
  final Talker _talker = getIt<Talker>();

  MyQrCodesBloc({
    required GetCreatedQrCodesUseCase getCreatedQrCodesUseCase,
    required SearchCreatedQrCodesUseCase searchCreatedQrCodesUseCase,
    required DeleteCreatedQrCodeUseCase deleteCreatedQrCodeUseCase,
  })  : _getCreatedQrCodesUseCase = getCreatedQrCodesUseCase,
        _searchCreatedQrCodesUseCase = searchCreatedQrCodesUseCase,
        _deleteCreatedQrCodeUseCase = deleteCreatedQrCodeUseCase,
        super(const MyQrCodesState()) {
    on<MyQrCodesInitialized>(_onInitialized);
    on<MyQrCodesCategoryChanged>(_onCategoryChanged);
    on<MyQrCodesSearchChanged>(_onSearchChanged);
    on<MyQrCodesItemDeleted>(_onItemDeleted);
    on<MyQrCodesRefreshed>(_onRefreshed);
  }

  Future<void> _onInitialized(
    MyQrCodesInitialized event,
    Emitter<MyQrCodesState> emit,
  ) async {
    await _loadQrCodes(emit, state.activeCategoryId);
  }

  Future<void> _onCategoryChanged(
    MyQrCodesCategoryChanged event,
    Emitter<MyQrCodesState> emit,
  ) async {
    emit(state.copyWith(activeCategoryId: event.categoryId));
    if (state.searchQuery != null && state.searchQuery!.isNotEmpty) {
      await _searchQrCodes(emit, state.searchQuery!);
    } else {
      await _loadQrCodes(emit, event.categoryId);
    }
  }

  Future<void> _onSearchChanged(
    MyQrCodesSearchChanged event,
    Emitter<MyQrCodesState> emit,
  ) async {
    emit(state.copyWith(searchQuery: event.query));
    if (event.query.isEmpty) {
      await _loadQrCodes(emit, state.activeCategoryId);
    } else {
      await _searchQrCodes(emit, event.query);
    }
  }

  Future<void> _onItemDeleted(
    MyQrCodesItemDeleted event,
    Emitter<MyQrCodesState> emit,
  ) async {
    try {
      _talker.info('Deleting created QR code: ${event.id}');
      await _deleteCreatedQrCodeUseCase.execute(event.id);
      await _loadQrCodes(emit, state.activeCategoryId);
      _talker.info('Created QR code deleted successfully');
    } catch (e, stackTrace) {
      _talker.error('Error deleting created QR code', e, stackTrace);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onRefreshed(
    MyQrCodesRefreshed event,
    Emitter<MyQrCodesState> emit,
  ) async {
    if (state.searchQuery != null && state.searchQuery!.isNotEmpty) {
      await _searchQrCodes(emit, state.searchQuery!);
    } else {
      await _loadQrCodes(emit, state.activeCategoryId);
    }
  }

  Future<void> _loadQrCodes(
    Emitter<MyQrCodesState> emit,
    String categoryId,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      _talker.info('Loading created QR codes with category: $categoryId');
      final qrCodes = await _getCreatedQrCodesUseCase.execute(
        categoryId: categoryId,
      );
      emit(state.copyWith(qrCodes: qrCodes, isLoading: false));
      _talker.info('Created QR codes loaded successfully: ${qrCodes.length}');
    } catch (e, stackTrace) {
      _talker.error('Error loading created QR codes', e, stackTrace);
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }

  Future<void> _searchQrCodes(
    Emitter<MyQrCodesState> emit,
    String query,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      _talker.info('Searching created QR codes with query: $query');
      final qrCodes = await _searchCreatedQrCodesUseCase.execute(query);
      emit(state.copyWith(qrCodes: qrCodes, isLoading: false));
      _talker.info('Search completed: ${qrCodes.length} results');
    } catch (e, stackTrace) {
      _talker.error('Error searching created QR codes', e, stackTrace);
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
