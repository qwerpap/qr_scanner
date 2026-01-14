import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:talker_flutter/talker_flutter.dart';
import '../../../scan_result/domain/entities/qr_code_type.dart';
import '../../domain/models/created_qr_code_model.dart';

class MyQrCodesLocalDataSource {
  static const String _keyCreatedQrCodes = 'created_qr_codes';
  final Talker _talker;

  MyQrCodesLocalDataSource({required Talker talker}) : _talker = talker;

  Future<void> saveCreatedQrCode(CreatedQrCodeModel qrCode) async {
    try {
      _talker.info('Saving created QR code to local storage');
      final prefs = await SharedPreferences.getInstance();
      final savedCodes = prefs.getStringList(_keyCreatedQrCodes) ?? [];
      
      final qrCodeJson = {
        'id': qrCode.id,
        'rawData': qrCode.rawData,
        'type': qrCode.type.name,
        'createdAt': qrCode.createdAt.toIso8601String(),
        'title': qrCode.title,
        'color': qrCode.color.value,
        'hasLogo': qrCode.hasLogo,
        'categoryId': qrCode.categoryId,
      };

      savedCodes.add(jsonEncode(qrCodeJson));
      await prefs.setStringList(_keyCreatedQrCodes, savedCodes);
      _talker.info('Created QR code saved successfully');
    } catch (e, stackTrace) {
      _talker.error('Error saving created QR code', e, stackTrace);
      rethrow;
    }
  }

  Future<List<CreatedQrCodeModel>> getAllCreatedQrCodes() async {
    try {
      _talker.info('Getting all created QR codes from local storage');
      final prefs = await SharedPreferences.getInstance();
      final savedCodes = prefs.getStringList(_keyCreatedQrCodes) ?? [];
      
      final qrCodes = <CreatedQrCodeModel>[];
      for (final codeJson in savedCodes) {
        try {
          final json = jsonDecode(codeJson) as Map<String, dynamic>;
          final qrCode = CreatedQrCodeModel(
            id: json['id'] as String,
            rawData: json['rawData'] as String,
            type: QrCodeType.values.firstWhere(
              (e) => e.name == json['type'] as String,
            ),
            createdAt: DateTime.parse(json['createdAt'] as String),
            title: json['title'] as String,
            color: Color(json['color'] as int),
            hasLogo: json['hasLogo'] as bool? ?? false,
            categoryId: json['categoryId'] as String?,
          );
          qrCodes.add(qrCode);
        } catch (e, stackTrace) {
          _talker.error('Error parsing created QR code: $codeJson', e, stackTrace);
        }
      }
      
      qrCodes.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      _talker.info('Retrieved ${qrCodes.length} created QR codes');
      return qrCodes;
    } catch (e, stackTrace) {
      _talker.error('Error getting created QR codes', e, stackTrace);
      rethrow;
    }
  }

  Future<void> deleteQrCode(String id) async {
    try {
      _talker.info('Deleting created QR code from local storage');
      final prefs = await SharedPreferences.getInstance();
      final savedCodes = prefs.getStringList(_keyCreatedQrCodes) ?? [];
      
      savedCodes.removeWhere((codeJson) {
        try {
          final json = jsonDecode(codeJson) as Map<String, dynamic>;
          return json['id'] as String == id;
        } catch (_) {
          return false;
        }
      });
      
      await prefs.setStringList(_keyCreatedQrCodes, savedCodes);
      _talker.info('Created QR code deleted successfully');
    } catch (e, stackTrace) {
      _talker.error('Error deleting created QR code', e, stackTrace);
      rethrow;
    }
  }

  Future<void> updateQrCode(CreatedQrCodeModel qrCode) async {
    try {
      _talker.info('Updating created QR code in local storage');
      final prefs = await SharedPreferences.getInstance();
      final savedCodes = prefs.getStringList(_keyCreatedQrCodes) ?? [];
      
      final qrCodeJson = {
        'id': qrCode.id,
        'rawData': qrCode.rawData,
        'type': qrCode.type.name,
        'createdAt': qrCode.createdAt.toIso8601String(),
        'title': qrCode.title,
        'color': qrCode.color.value,
        'hasLogo': qrCode.hasLogo,
        'categoryId': qrCode.categoryId,
      };

      final index = savedCodes.indexWhere((codeJson) {
        try {
          final json = jsonDecode(codeJson) as Map<String, dynamic>;
          return json['id'] as String == qrCode.id;
        } catch (_) {
          return false;
        }
      });

      if (index != -1) {
        savedCodes[index] = jsonEncode(qrCodeJson);
        await prefs.setStringList(_keyCreatedQrCodes, savedCodes);
        _talker.info('Created QR code updated successfully');
      } else {
        throw Exception('QR code with id ${qrCode.id} not found');
      }
    } catch (e, stackTrace) {
      _talker.error('Error updating created QR code', e, stackTrace);
      rethrow;
    }
  }
}
