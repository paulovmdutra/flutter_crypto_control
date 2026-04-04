import 'package:flutter_crypto_control/domain/models/entities.dart';
import 'package:flutter_crypto_control/pages/app/generic_form/generic_container_page.dart';
import 'package:flutter_crypto_control/view_model/category_view_model.dart';

class SubCategoryModel extends GenericModel<SubCategory> {
  SubCategoryModel({required super.entities});
}

class CategoryModel extends GenericModel<CategoryViewModel> {
  final List<CategoryViewModel?> incomeCategories;
  final List<CategoryViewModel?> expenseCategories;

  CategoryModel({
    required super.entities,
    required this.incomeCategories,
    required this.expenseCategories,
  });
}
