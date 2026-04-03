import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/pages/category/category_form_dialog.dart';
import 'package:flutter_crypto_control/pages/providers/category_providers.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_crypto_control/shared/view_async.dart';
import 'package:flutter_crypto_control/widgets/app_scaffold.dart';
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
  final Category? category;

  const FormWidgetAdapter({super.key, this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCategoriesAsync = ref.watch(categoryControllerProvider);
    final stateCategories = allCategoriesAsync.toViewAsync();

    // 2. Define a função de ação AQUI
    Future<CommonResult<Category?>> handleSave(Category subCategory) async {
      if (subCategory.id != 0) {
        await ref
            .read(categoryControllerProvider.notifier)
            .updateCategory(subCategory);
      } else {
        await ref
            .read(categoryControllerProvider.notifier)
            .addCategory(subCategory);
      }
      return CommonResult<Category?>.success(data: category);
    }

    return stateCategories.when(
      loading: () => const WaitingWidget(),
      error: (error, stackTrace) {
        CommonResult<Category?> result = error as CommonResult<Category?>;
        return AppScaffold(
          title: 'Categoria',
          body: ErrorInfoWidget(
            error: ErrorDescription(
              result.error?.details ?? 'Erro desconhecido',
            ),
            onReload: () {
              ref.read(categoryControllerProvider.notifier).loadCategories();
            },
          ),
        );
      },
      data: (data) {
        return CategoryForm(
          state: stateCategories,
          entityToEdit: category,
          onActionSubmit: (data) async {
            return await handleSave(data!.data!);
          },
          onReload: () {
            ref.read(categoryControllerProvider.notifier).loadCategories();
          },
        );
      },
    );
  }
}
