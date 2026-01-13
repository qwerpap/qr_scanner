import 'package:equatable/equatable.dart';

class FeatureModel extends Equatable {
  const FeatureModel({
    required this.id,
    required this.title,
    required this.description,
    required this.iconPath,
  });

  final String id;
  final String title;
  final String description;
  final String iconPath;

  @override
  List<Object?> get props => [id, title, description, iconPath];
}
