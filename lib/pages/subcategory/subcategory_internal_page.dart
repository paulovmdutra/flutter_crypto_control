import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/sub_category.dart';
import 'package:flutter_crypto_control/pages/models_page.dart';
import 'package:flutter_crypto_control/pages/subcategory/subcategory_management_page.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_crypto_control/shared/view_async.dart';
import 'package:flutter_crypto_control/widgets/app_colors.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';

class SubCategoryInternalPage extends StatelessWidget {
  // Injetar o estado (dados)
  final ViewAsync<CommonResult<List<SubCategory?>?>> state;

  // Injetar as funções de ação (callbacks)
  final VoidCallback onAddCategory;
  final VoidCallback onReload;

  final SubCategoryModel categoryModel;

  const SubCategoryInternalPage({
    super.key,
    required this.state,
    required this.categoryModel,
    required this.onAddCategory,
    required this.onReload,
  });

  @override
  Widget build(BuildContext context) {
    if (state is ViewAsyncLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (state is ViewAsyncError) {
      final errorState = state as ViewAsyncError;
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 40),
              const SizedBox(height: 8),
              Text(
                'Erro ao carregar categorias:\n${errorState.error.toString()}',
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: onReload, // Usa o callback injetado
                child: const Text('Tentar Novamente'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      body: SubCategoryManagementPage(
        state: state,
        viewModel: categoryModel,
        onAddCategory: onAddCategory, // Callback injetado
        onReload: onReload, // Callback injetado
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onAddCategory,
        heroTag:
            "fab_aba_3", // Disables the Hero animation entirely for this button
        icon: const Icon(Icons.add),
        label: const Text('Nova Categoria'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }
}
