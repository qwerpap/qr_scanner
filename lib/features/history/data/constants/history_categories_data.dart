import 'package:qr_scanner/features/my_qr_codes/data/models/category_model.dart';

class HistoryCategoriesData {
  static const List<CategoryModel> categories = [
    CategoryModel(id: 'all', title: 'All'),
    CategoryModel(id: 'scanned', title: 'Scanned'),
    CategoryModel(id: 'created', title: 'Created'),
  ];
}
