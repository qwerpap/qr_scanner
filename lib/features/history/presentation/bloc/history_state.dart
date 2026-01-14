import 'package:equatable/equatable.dart';
import '../../domain/models/history_group_model.dart';

class HistoryState extends Equatable {
  final List<HistoryGroupModel> groups;
  final String activeCategoryId;
  final bool isLoading;
  final String? errorMessage;

  const HistoryState({
    this.groups = const [],
    this.activeCategoryId = 'all',
    this.isLoading = false,
    this.errorMessage,
  });

  HistoryState copyWith({
    List<HistoryGroupModel>? groups,
    String? activeCategoryId,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HistoryState(
      groups: groups ?? this.groups,
      activeCategoryId: activeCategoryId ?? this.activeCategoryId,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        groups,
        activeCategoryId,
        isLoading,
        errorMessage,
      ];
}
