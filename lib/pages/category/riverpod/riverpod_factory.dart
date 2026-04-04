import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/pages/category/riverpod/category_container_adapter.dart';
import 'package:flutter_crypto_control/pages/category/riverpod/category_list_adapter.dart';
import 'package:flutter_crypto_control/pages/category/riverpod/form_widget_adapter.dart';
import 'package:flutter_crypto_control/pages/ipages_factory.dart';
import 'package:flutter_crypto_control/view_model/category_view_model.dart';

class RiverpodCategoryFactory extends ICategoryFactory {
  @override
  Widget createContainerMainPage({List<CategoryViewModel?>? categories}) {
    return CategoryContainerAdapter();
  }

  @override
  @override
  Widget createForm({
    CategoryViewModel? subcategory,
    CategoryViewModel? category,
    List<CategoryViewModel?>? categories,
  }) {
    return FormWidgetAdapter(category: category);
  }

  @override
  Widget createlListView({List<CategoryViewModel?>? categories}) {
    return CategoryListViewAdapter(categories: categories);
  }
}
