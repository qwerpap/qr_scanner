import '../repositories/history_repository.dart';

class DeleteQrCodeUseCase {
  final HistoryRepository repository;

  DeleteQrCodeUseCase(this.repository);

  Future<void> execute(String id) async {
    await repository.deleteQrCode(id);
  }
}
