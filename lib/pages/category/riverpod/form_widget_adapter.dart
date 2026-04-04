import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/pages/category/category_form_dialog.dart';
import 'package:flutter_crypto_control/pages/providers/category_providers.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_crypto_control/view_model/category_view_model.dart';
import 'package:flutter_crypto_control/widgets/app_scaffold.dart';
import 'package:flutter_crypto_control/widgets/error_info_widget.dart';
import 'package:flutter_crypto_control/widgets/waiting.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_crypto_control/shared/extensions/async_value_extensions.dart';

class FormWidgetAdapter extends ConsumerWidget {
  final CategoryViewModel? category;

  const FormWidgetAdapter({super.key, this.category});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final allCategoriesAsync = ref.watch(categoryControllerProvider);
    final stateCategories = allCategoriesAsync.toViewAsync();

    // 2. Define a função de ação AQUI
    Future<CommonResult<CategoryViewModel?>> handleSave(
      CategoryViewModel categoryData,
    ) async {
      await ref.read(categoryControllerProvider.notifier).save(categoryData);
      return CommonResult<CategoryViewModel?>.success(data: categoryData);
    }
    
    return stateCategories.when(
      loading: () => const WaitingWidget(),
      error: (error, stackTrace) {
        CommonResult<CategoryViewModel?> result =
            error as CommonResult<CategoryViewModel?>;
        return AppScaffold(
          title: 'Categoria',
          body: ErrorInfoWidget(
            error: ErrorDescription(
              result.error?.details ?? 'Erro desconhecido',
            ),
            onReload: () {
              ref.read(categoryControllerProvider.notifier).loadData();
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
            ref.read(categoryControllerProvider.notifier).loadData();
          },
        );
      },
    );
  }
}
