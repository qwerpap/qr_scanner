import '../models/created_qr_code_model.dart';
import '../repositories/my_qr_codes_repository.dart';

class SearchCreatedQrCodesUseCase {
  final MyQrCodesRepository repository;

  SearchCreatedQrCodesUseCase(this.repository);

  Future<List<CreatedQrCodeModel>> execute(String query) async {
    return await repository.searchCreatedQrCodes(query);
  }
}
