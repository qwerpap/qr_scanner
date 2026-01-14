import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../../core/bloc/bloc_providers.dart';
import '../../domain/usecases/clear_history_usecase.dart';
import '../../domain/usecases/delete_qr_code_usecase.dart';
import '../../domain/usecases/get_history_usecase.dart';
import 'history_event.dart';
import 'history_state.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final GetHistoryUseCase _getHistoryUseCase;
  final DeleteQrCodeUseCase _deleteQrCodeUseCase;
  final ClearHistoryUseCase _clearHistoryUseCase;
  final Talker _talker = getIt<Talker>();

  HistoryBloc({
    required GetHistoryUseCase getHistoryUseCase,
    required DeleteQrCodeUseCase deleteQrCodeUseCase,
    required ClearHistoryUseCase clearHistoryUseCase,
  }) : _getHistoryUseCase = getHistoryUseCase,
       _deleteQrCodeUseCase = deleteQrCodeUseCase,
       _clearHistoryUseCase = clearHistoryUseCase,
       super(const HistoryState()) {
    on<HistoryInitialized>(_onInitialized);
    on<HistoryCategoryChanged>(_onCategoryChanged);
    on<HistoryItemDeleted>(_onItemDeleted);
    on<HistoryCleared>(_onCleared);
    on<HistoryRefreshed>(_onRefreshed);
  }

  Future<void> _onInitialized(
    HistoryInitialized event,
    Emitter<HistoryState> emit,
  ) async {
    await _loadHistory(emit, state.activeCategoryId);
  }

  Future<void> _onCategoryChanged(
    HistoryCategoryChanged event,
    Emitter<HistoryState> emit,
  ) async {
    emit(state.copyWith(activeCategoryId: event.categoryId));
    await _loadHistory(emit, event.categoryId);
  }

  Future<void> _onItemDeleted(
    HistoryItemDeleted event,
    Emitter<HistoryState> emit,
  ) async {
    try {
      _talker.info('Deleting history item: ${event.id}');
      await _deleteQrCodeUseCase.execute(event.id);
      await _loadHistory(emit, state.activeCategoryId);
      _talker.info('History item deleted successfully');
    } catch (e, stackTrace) {
      _talker.error('Error deleting history item', e, stackTrace);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onCleared(
    HistoryCleared event,
    Emitter<HistoryState> emit,
  ) async {
    try {
      _talker.info('Clearing history');
      await _clearHistoryUseCase.execute();
      emit(state.copyWith(groups: []));
      _talker.info('History cleared successfully');
    } catch (e, stackTrace) {
      _talker.error('Error clearing history', e, stackTrace);
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }

  Future<void> _onRefreshed(
    HistoryRefreshed event,
    Emitter<HistoryState> emit,
  ) async {
    await _loadHistory(emit, state.activeCategoryId);
  }

  Future<void> _loadHistory(
    Emitter<HistoryState> emit,
    String categoryId,
  ) async {
    emit(state.copyWith(isLoading: true, errorMessage: null));
    try {
      _talker.info('Loading history with category: $categoryId');
      final groups = await _getHistoryUseCase.execute(categoryId: categoryId);
      emit(state.copyWith(groups: groups, isLoading: false));
      _talker.info('History loaded successfully: ${groups.length} groups');
    } catch (e, stackTrace) {
      _talker.error('Error loading history', e, stackTrace);
      emit(state.copyWith(isLoading: false, errorMessage: e.toString()));
    }
  }
}
