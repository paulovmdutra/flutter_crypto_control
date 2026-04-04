import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/pages/category/category_list_view.dart';
import 'package:flutter_crypto_control/pages/ipages_factory.dart';
import 'package:flutter_crypto_control/pages/providers/category_providers.dart';
import 'package:flutter_crypto_control/service_locator.dart';
import 'package:flutter_crypto_control/view_model/category_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryListViewAdapter extends ConsumerWidget {
  final List<CategoryViewModel?>? categories;

  const CategoryListViewAdapter({super.key, required this.categories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CategoryListView(
      categories: categories,

      // AÇÃO: Deletar (Usa o Riverpod)
      onDelete: (subCategory) {
        ref
            .read(categoryControllerProvider.notifier)
            .delete(subCategory.toEntity());
      },

      // AÇÃO: Editar (Usa o Service Locator e abre Dialog)
      onEdit: (category) {
        showDialog(
          context: context,
          builder: (context) {
            return ServiceLocator.instance.get<ICategoryFactory>().createForm(
              category: category,
            );
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
