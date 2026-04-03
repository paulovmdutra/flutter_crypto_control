import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/pages/category/riverpod/category_container_adapter.dart';
import 'package:flutter_crypto_control/pages/category/riverpod/category_list_adapter.dart';
import 'package:flutter_crypto_control/pages/category/riverpod/form_widget_adapter.dart';
import 'package:flutter_crypto_control/pages/ipages_factory.dart';

class RiverpodCategoryFactory extends ICategoryFactory {
  @override
  Widget createContainerMainPage({List<Category?>? categories}) {
    return CategoryContainerAdapter();
  }

  @override
  @override
  Widget createForm({
    Category? subcategory,
    Category? category,
    List<Category?>? categories,
  }) {
    return FormWidgetAdapter(category: category);
  }

  @override
  Widget createlListView({List<Category?>? categories}) {
    return CategoryListViewAdapter(categories: categories);
  }

  /*@override
  Widget createForm({Category? category}) {
    return FormWidgetAdapter(subcategory: subcategory);
  }

  @override
  Widget createContainerMainPage({List<Category?>? subcategories}) {
    return SubCategoryContainerAdapter();
  }

  @override
  Widget createlListView({List<Category?>? subcategories}) {
    return SubCategoryListViewAdapter(subcategories: subcategories);
  }*/
}
