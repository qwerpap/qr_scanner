import 'package:equatable/equatable.dart';
import '../../domain/models/recent_activity_model.dart';

class HomeState extends Equatable {
  final List<RecentActivityModel> recentActivities;
  final int savedQrCodesCount;
  final bool isLoading;
  final String? errorMessage;

  const HomeState({
    this.recentActivities = const [],
    this.savedQrCodesCount = 0,
    this.isLoading = false,
    this.errorMessage,
  });

  HomeState copyWith({
    List<RecentActivityModel>? recentActivities,
    int? savedQrCodesCount,
    bool? isLoading,
    String? errorMessage,
  }) {
    return HomeState(
      recentActivities: recentActivities ?? this.recentActivities,
      savedQrCodesCount: savedQrCodesCount ?? this.savedQrCodesCount,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    recentActivities,
    savedQrCodesCount,
    isLoading,
    errorMessage,
  ];
}
