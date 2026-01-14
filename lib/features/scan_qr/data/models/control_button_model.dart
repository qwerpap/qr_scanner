import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ControlButtonModel extends Equatable {
  const ControlButtonModel({
    required this.id,
    required this.label,
    required this.icon,
    required this.onTap,
    this.isActive = false,
  });

  final String id;
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;

  @override
  List<Object?> get props => [id, label, icon, isActive];
}
