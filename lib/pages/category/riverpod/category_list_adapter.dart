import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/pages/category/category_list_view.dart';
import 'package:flutter_crypto_control/pages/providers/category_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryListViewAdapter extends ConsumerWidget {
  final List<Category?>? categories;

  const CategoryListViewAdapter({super.key, required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CategoryListView(
      categories: categories,

      // AÇÃO: Deletar (Usa o Riverpod)
      onDelete: (subCategory) {
        ref
            .read(categoryControllerProvider.notifier)
            .deleteCategory(subCategory);
      },

      // AÇÃO: Editar (Usa o Service Locator e abre Dialog)
      onEdit: (subCategory) {
        showDialog(
          context: context,
          builder: (context) {
            return Container();
            /*return ServiceLocator.instance
                .get<ISubCategoryFactory>()
                .createForm(subcategory: subCategory);*/
          },
        );
      },

      // AÇÃO: Arquivar (Opcional)
      onArchive: (category) {
        // ref.read(...).archive(...)
      },
    );
  }
}
