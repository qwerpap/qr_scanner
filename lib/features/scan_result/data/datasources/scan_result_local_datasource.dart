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
        'isCreated': qrCodeData.isCreated,
      };

      savedCodes.add(jsonEncode(qrCodeJson));
      await prefs.setStringList(_keyQrCodes, savedCodes);
      _talker.info('QR code saved successfully');
    } catch (e, stackTrace) {
      _talker.error('Error saving QR code', e, stackTrace);
      rethrow;
    }
  }

  Future<List<QrCodeData>> getAllQrCodes() async {
    try {
      _talker.info('Getting all QR codes from local storage');
      final prefs = await SharedPreferences.getInstance();
      final savedCodes = prefs.getStringList(_keyQrCodes) ?? [];
      
      final qrCodes = <QrCodeData>[];
      for (final codeJson in savedCodes) {
        try {
          final json = jsonDecode(codeJson) as Map<String, dynamic>;
          final qrCode = QrCodeData(
            rawData: json['rawData'] as String,
            type: QrCodeType.values.firstWhere(
              (e) => e.name == json['type'] as String,
            ),
            scannedAt: DateTime.parse(json['scannedAt'] as String),
            title: json['title'] as String?,
            url: json['url'] as String?,
            isCreated: json['isCreated'] as bool? ?? false,
          );
          qrCodes.add(qrCode);
        } catch (e, stackTrace) {
          _talker.error('Error parsing QR code: $codeJson', e, stackTrace);
        }
      }
      
      qrCodes.sort((a, b) => b.scannedAt.compareTo(a.scannedAt));
      _talker.info('Retrieved ${qrCodes.length} QR codes');
      return qrCodes;
    } catch (e, stackTrace) {
      _talker.error('Error getting QR codes', e, stackTrace);
      rethrow;
    }
  }

  Future<List<QrCodeData>> getRecentQrCodes({int limit = 10}) async {
    try {
      final allCodes = await getAllQrCodes();
      return allCodes.take(limit).toList();
    } catch (e, stackTrace) {
      _talker.error('Error getting recent QR codes', e, stackTrace);
      rethrow;
    }
  }

  Future<void> deleteQrCode(String rawData) async {
    try {
      _talker.info('Deleting QR code from local storage');
      final prefs = await SharedPreferences.getInstance();
      final savedCodes = prefs.getStringList(_keyQrCodes) ?? [];
      
      savedCodes.removeWhere((codeJson) {
        try {
          final json = jsonDecode(codeJson) as Map<String, dynamic>;
          return json['rawData'] as String == rawData;
        } catch (_) {
          return false;
        }
      });
      
      await prefs.setStringList(_keyQrCodes, savedCodes);
      _talker.info('QR code deleted successfully');
    } catch (e, stackTrace) {
      _talker.error('Error deleting QR code', e, stackTrace);
      rethrow;
    }
  }

  Future<void> clearAllQrCodes() async {
    try {
      _talker.info('Clearing all QR codes from local storage');
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_keyQrCodes);
      _talker.info('All QR codes cleared successfully');
    } catch (e, stackTrace) {
      _talker.error('Error clearing QR codes', e, stackTrace);
      rethrow;
    }
  }

  Future<void> updateQrCode(QrCodeData qrCodeData) async {
    try {
      _talker.info('Updating QR code in local storage');
      final prefs = await SharedPreferences.getInstance();
      final savedCodes = prefs.getStringList(_keyQrCodes) ?? [];
      
      final qrCodeJson = {
        'rawData': qrCodeData.rawData,
        'type': qrCodeData.type.name,
        'scannedAt': qrCodeData.scannedAt.toIso8601String(),
        'title': qrCodeData.title,
        'url': qrCodeData.url,
        'isCreated': qrCodeData.isCreated,
      };

      // Find and update the QR code with matching rawData and isCreated flag
      final index = savedCodes.indexWhere((codeJson) {
        try {
          final json = jsonDecode(codeJson) as Map<String, dynamic>;
          return json['rawData'] as String == qrCodeData.rawData &&
                 (json['isCreated'] as bool? ?? false) == qrCodeData.isCreated;
        } catch (_) {
          return false;
        }
      });

      if (index != -1) {
        savedCodes[index] = jsonEncode(qrCodeJson);
        await prefs.setStringList(_keyQrCodes, savedCodes);
        _talker.info('QR code updated successfully');
      } else {
        // If not found, just save as new
        savedCodes.add(jsonEncode(qrCodeJson));
        await prefs.setStringList(_keyQrCodes, savedCodes);
        _talker.info('QR code not found, saved as new');
      }
    } catch (e, stackTrace) {
      _talker.error('Error updating QR code', e, stackTrace);
      rethrow;
    }
  }
}
