import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class RecentActivityModel extends Equatable {
  final String title;
  final String timestamp;
  final String? iconPath;
  final IconData? iconData;
  final Color color;

  const RecentActivityModel({
    required this.title,
    required this.timestamp,
    this.iconPath,
    this.iconData,
    required this.color,
  }) : assert(
          iconPath != null || iconData != null,
          'Either iconPath or iconData must be provided',
        );

  @override
  List<Object?> get props => [title, timestamp, iconPath, iconData, color];
}
