import 'package:qr_scanner/features/my_qr_codes/data/models/category_model.dart';

class CategoriesData {
  static const List<CategoryModel> categories = [
    CategoryModel(id: 'all', title: 'All'),
    CategoryModel(id: 'url', title: 'URL'),
    CategoryModel(id: 'text', title: 'Text'),
    CategoryModel(id: 'wifi', title: 'WiFi'),
    CategoryModel(id: 'contact', title: 'Contact'),
  ];
}
