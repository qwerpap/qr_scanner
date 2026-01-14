import '../repositories/my_qr_codes_repository.dart';

class DeleteCreatedQrCodeUseCase {
  final MyQrCodesRepository repository;

  DeleteCreatedQrCodeUseCase(this.repository);

  Future<void> execute(String id) async {
    await repository.deleteQrCode(id);
  }
}
