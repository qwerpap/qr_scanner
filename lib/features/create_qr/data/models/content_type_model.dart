import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ContentTypeModel extends Equatable {
  const ContentTypeModel({
    required this.id,
    required this.title,
    required this.iconData,
  });

  final String id;
  final String title;
  final IconData iconData;

  @override
  List<Object?> get props => [id, title, iconData];
}
