import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ActionCardModel extends Equatable {
  final String title;
  final String subtitle;
  final String? iconPath;
  final IconData? iconData;
  final Color color;

  const ActionCardModel({
    required this.title,
    required this.subtitle,
    this.iconPath,
    this.iconData,
    required this.color,
  }) : assert(
         iconPath != null || iconData != null,
         'Either iconPath or iconData must be provided',
       );

  @override
  List<Object?> get props => [title, subtitle, iconPath, iconData, color];
}
