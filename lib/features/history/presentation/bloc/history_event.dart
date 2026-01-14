import 'package:equatable/equatable.dart';

class HistoryEvent extends Equatable {
  const HistoryEvent();

  @override
  List<Object?> get props => [];
}

class HistoryInitialized extends HistoryEvent {
  const HistoryInitialized();
}

class HistoryCategoryChanged extends HistoryEvent {
  final String categoryId;

  const HistoryCategoryChanged(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}

class HistoryItemDeleted extends HistoryEvent {
  final String id;

  const HistoryItemDeleted(this.id);

  @override
  List<Object?> get props => [id];
}

class HistoryCleared extends HistoryEvent {
  const HistoryCleared();
}

class HistoryRefreshed extends HistoryEvent {
  const HistoryRefreshed();
}
