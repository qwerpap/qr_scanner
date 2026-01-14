import '../../domain/models/created_qr_code_model.dart';
import '../../domain/repositories/my_qr_codes_repository.dart';
import '../datasources/my_qr_codes_local_datasource.dart';

class MyQrCodesRepositoryImpl implements MyQrCodesRepository {
  final MyQrCodesLocalDataSource _localDataSource;

  MyQrCodesRepositoryImpl({required MyQrCodesLocalDataSource localDataSource})
    : _localDataSource = localDataSource;

  @override
  Future<List<CreatedQrCodeModel>> getCreatedQrCodes({
    String? categoryId,
  }) async {
    final allCodes = await _localDataSource.getAllCreatedQrCodes();

    if (categoryId == null || categoryId == 'all') {
      return allCodes;
    }

    return allCodes.where((code) {
      if (categoryId == 'url') return code.type.name == 'url';
      if (categoryId == 'text') return code.type.name == 'text';
      if (categoryId == 'wifi') return code.type.name == 'wifi';
      if (categoryId == 'contact') return code.type.name == 'vcard';
      return false;
    }).toList();
  }

  @override
  Future<List<CreatedQrCodeModel>> searchCreatedQrCodes(String query) async {
    final allCodes = await _localDataSource.getAllCreatedQrCodes();
    final lowerQuery = query.toLowerCase();

    return allCodes.where((code) {
      return code.title.toLowerCase().contains(lowerQuery) ||
          code.rawData.toLowerCase().contains(lowerQuery);
    }).toList();
  }

  @override
  Future<void> saveCreatedQrCode(CreatedQrCodeModel qrCode) async {
    await _localDataSource.saveCreatedQrCode(qrCode);
  }

  @override
  Future<void> deleteQrCode(String id) async {
    await _localDataSource.deleteQrCode(id);
  }

  @override
  Future<void> updateQrCode(CreatedQrCodeModel qrCode) async {
    await _localDataSource.updateQrCode(qrCode);
  }
}
