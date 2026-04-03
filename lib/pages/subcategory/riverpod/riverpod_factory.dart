import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/domain/models/sub_category.dart';
import 'package:flutter_crypto_control/pages/ipages_factory.dart';
import 'package:flutter_crypto_control/pages/subcategory/riverpod/form_widget_adapter.dart';
import 'package:flutter_crypto_control/pages/subcategory/riverpod/subcategory_container_adapter.dart';
import 'package:flutter_crypto_control/pages/subcategory/riverpod/subcategory_list_adapter.dart';

class RiverpodSubCategoryFactory extends ISubCategoryFactory {
  @override
  Widget createForm({
    SubCategory? subcategory,
    Category? category,
    List<Category?>? categories,
  }) {
    return FormWidgetAdapter(
      subcategory: subcategory,
      category: category,
      categories: categories,
    );
  }

  @override
  Widget createContainerMainPage({List<SubCategory?>? subcategories}) {
    return SubCategoryContainerAdapter();
  }

  @override
  Widget createlListView({List<SubCategory?>? subcategories}) {
    return SubCategoryListViewAdapter(subcategories: subcategories);
  }
}
