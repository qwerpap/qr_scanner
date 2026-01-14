import '../repositories/history_repository.dart';

class ClearHistoryUseCase {
  final HistoryRepository repository;

  ClearHistoryUseCase(this.repository);

  Future<void> execute() async {
    await repository.clearHistory();
  }
}
