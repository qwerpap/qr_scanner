import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../domain/entities/qr_code_type.dart';

class ScanResultLocalDataSource {
  static const String _keyQrCodes = 'saved_qr_codes';
  final Talker _talker;

  ScanResultLocalDataSource({required Talker talker}) : _talker = talker;

  Future<void> saveQrCode(QrCodeData qrCodeData) async {
    try {
      _talker.info('Saving QR code to local storage');
      final prefs = await SharedPreferences.getInstance();
      final savedCodes = prefs.getStringList(_keyQrCodes) ?? [];
      
      final qrCodeJson = {
        'rawData': qrCodeData.rawData,
        'type': qrCodeData.type.name,
        'scannedAt': qrCodeData.scannedAt.toIso8601String(),
        'title': qrCodeData.title,
        'url': qrCodeData.url,
      };

      savedCodes.add(jsonEncode(qrCodeJson));
      await prefs.setStringList(_keyQrCodes, savedCodes);
      _talker.info('QR code saved successfully');
    } catch (e, stackTrace) {
      _talker.error('Error saving QR code', e, stackTrace);
      rethrow;
    }
  }
}
