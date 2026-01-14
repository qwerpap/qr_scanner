import '../models/created_qr_code_model.dart';

abstract class MyQrCodesRepository {
  Future<List<CreatedQrCodeModel>> getCreatedQrCodes({String? categoryId});
  Future<List<CreatedQrCodeModel>> searchCreatedQrCodes(String query);
  Future<void> saveCreatedQrCode(CreatedQrCodeModel qrCode);
  Future<void> deleteQrCode(String id);
  Future<void> updateQrCode(CreatedQrCodeModel qrCode);
}
