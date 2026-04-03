import 'package:flutter/cupertino.dart';
import 'package:flutter_crypto_control/domain/models/entities.dart';

abstract class ISubCategoryFactory {
  Widget createForm({
    SubCategory? subcategory,
    Category? category,
    List<Category?>? categories,
  });
  Widget createContainerMainPage({List<SubCategory?>? subcategories});
  Widget createlListView({List<SubCategory?>? subcategories});
}

abstract class ICategoryFactory {
  Widget createForm({Category? category});
  Widget createContainerMainPage({List<Category?>? categories});
  Widget createlListView({List<Category?>? categories});
}
