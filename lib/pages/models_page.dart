import 'package:flutter_crypto_control/domain/models/entities.dart';
import 'package:flutter_crypto_control/pages/app/generic_form/generic_container_page.dart';

class SubCategoryModel extends GenericModel<SubCategory> {
  SubCategoryModel({required super.entities});
}

class CategoryModel extends GenericModel<Category> {
  final List<Category?> incomeCategories;
  final List<Category?> expenseCategories;

  CategoryModel({
    required super.entities,
    required this.incomeCategories,
    required this.expenseCategories,
  });
}
