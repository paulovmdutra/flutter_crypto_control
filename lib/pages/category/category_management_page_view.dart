import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/pages/app/generic_form/generic_management_page_view.dart';
import 'package:flutter_crypto_control/pages/ipages_factory.dart';
import 'package:flutter_crypto_control/pages/models_page.dart';
import 'package:flutter_crypto_control/service_locator.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_crypto_control/widgets/app_colors.dart';

class CategoryManagementPage
    extends GenericManagementPageView<Category, CategoryModel> {
  const CategoryManagementPage({
    super.key,
    required super.state,
    required super.viewModel,
    required super.onAddCategory,
    required super.onReload,
  });

  @override
  Widget? builderContainer(
    BuildContext context,
    CommonResult<List<Category?>?> data,
  ) {
    return _list(context, data);
  }

  Widget _cardInfo(BuildContext context, List<Category?> categories) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: const Text(
          'Total Categorias',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        trailing: Text(
          '${categories.length}',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        onTap: onAddCategory,
        leading: const Icon(Icons.category, color: AppColors.primary),
      ),
    );
  }

  Widget _list(BuildContext context, CommonResult<List<Category?>?> categories) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [Flexible(child: _cardInfo(context, categories.data!))],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ServiceLocator.instance
                  .get<ICategoryFactory>()
                  .createlListView(categories: viewModel.incomeCategories),
            ),
          ],
        ),

        const Divider(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ServiceLocator.instance
                  .get<ICategoryFactory>()
                  .createlListView(categories: viewModel.expenseCategories),
            ),
          ],
        ),
      ],
    );
  }
}
