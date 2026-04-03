import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/domain/models/sub_category.dart';
import 'package:flutter_crypto_control/pages/providers/category_providers.dart';
import 'package:flutter_crypto_control/pages/providers/subcategory_providers.dart';
import 'package:flutter_crypto_control/pages/subcategory/subcategory_form.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_crypto_control/shared/view_async.dart';
import 'package:flutter_crypto_control/widgets/error_info_widget.dart';
import 'package:flutter_crypto_control/widgets/waiting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueExtensions<T> on AsyncValue<T> {
  ViewAsync<T> toViewAsync() {
    return when(
      loading: () => ViewAsyncLoading<T>(),
      error: (err, stack) => ViewAsyncError<T>(err, stack),
      data: (data) => ViewAsyncData<T>(data),
    );
  }
}

class FormWidgetAdapter extends ConsumerWidget {
  final SubCategory? subcategory;
  final Category? category;
  final List<Category?>? categories;

  const FormWidgetAdapter({
    super.key,
    this.subcategory,
    this.category,
    this.categories,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    AsyncValue<CommonResult<List<Category?>?>>? allCategoriesAsync;
    AsyncValue<CommonResult<List<SubCategory?>?>>? subCategoriesAsync;
    ViewAsync<CommonResult<List<Category?>?>>? stateCategories;

    if (categories == null) {
      allCategoriesAsync = ref.watch(categoryControllerProvider);
      stateCategories = allCategoriesAsync!.toViewAsync();
    }

    subCategoriesAsync = ref.watch(subCategoryControllerProvider);

    // 2. Define a função de ação AQUI
    Future<CommonResult<SubCategory?>?> handleSave(
      SubCategory subCategory,
    ) async {
      if (subCategory.id != 0) {
        await ref
            .read(subCategoryControllerProvider.notifier)
            .updateSubCategory(subCategory);
      } else {
        await ref
            .read(subCategoryControllerProvider.notifier)
            .addSubCategory(subCategory);
      }
      return CommonResult<SubCategory?>.success(data: subcategory);
    }

    if (stateCategories != null) {
      return stateCategories.when(
        loading: () => const WaitingWidget(),
        error: (error, _) => ErrorInfoWidget(
          error: ErrorDescription(error.toString()),
          onReload: () {
            ref.read(subCategoryControllerProvider.notifier).loadCategories();
          },
        ),
        data: (data) {
          List<Category>? listCategories = [];
          late final allCategories;
          if (allCategoriesAsync != null &&
              allCategoriesAsync.value != null &&
              allCategoriesAsync.value?.data != null) {
            allCategories = allCategoriesAsync.value?.data;
            listCategories = allCategories.whereType<Category>().toList();
          }
          return _createForm(subCategoriesAsync, listCategories, handleSave);
        },
      );
    } else {
      List<Category?>? listCategories = categories?.toList();
      return _createForm(subCategoriesAsync, listCategories, handleSave);
    }
  }

  SubCategoryForm _createForm(
    AsyncValue<CommonResult<List<SubCategory?>?>>? subCategoriesAsync,
    List<Category?>? categories,
    Future<CommonResult<SubCategory?>?> Function(SubCategory subCategory)
    handleSave,
  ) {
    final state = subCategoriesAsync!.toViewAsync();

    return SubCategoryForm(
      state: state,
      entityToEdit: subcategory,
      parentCategory: category,
      // Passa os dados e a função de ação para o Widget independente
      listCategories: categories,
      onActionSubmit: (data) async {
        return await handleSave(data!.data!);
      },
    );
  }
}
