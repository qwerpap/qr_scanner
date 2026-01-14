import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../scan_result/domain/entities/qr_code_type.dart';

class CreatedQrCodeModel extends Equatable {
  const CreatedQrCodeModel({
    required this.id,
    required this.rawData,
    required this.type,
    required this.createdAt,
    required this.title,
    required this.color,
    this.hasLogo = false,
    this.logoPath,
    this.categoryId,
  });

  final String id;
  final String rawData;
  final QrCodeType type;
  final DateTime createdAt;
  final String title;
  final Color color;
  final bool hasLogo;
  final String? logoPath;
  final String? categoryId;

  @override
  List<Object?> get props => [
        id,
        rawData,
        type,
        createdAt,
        title,
        color,
        hasLogo,
        logoPath,
        categoryId,
      ];
}
