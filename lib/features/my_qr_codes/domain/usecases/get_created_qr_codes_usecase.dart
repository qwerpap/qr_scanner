import '../models/created_qr_code_model.dart';
import '../repositories/my_qr_codes_repository.dart';

class GetCreatedQrCodesUseCase {
  final MyQrCodesRepository repository;

  GetCreatedQrCodesUseCase(this.repository);

  Future<List<CreatedQrCodeModel>> execute({String? categoryId}) async {
    return await repository.getCreatedQrCodes(categoryId: categoryId);
  }
}
