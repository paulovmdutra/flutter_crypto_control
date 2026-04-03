import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/sub_category.dart';
import 'package:flutter_crypto_control/pages/ipages_factory.dart';
import 'package:flutter_crypto_control/pages/providers/subcategory_providers.dart';
import 'package:flutter_crypto_control/pages/subcategory/subcategory_list_view.dart';
import 'package:flutter_crypto_control/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubCategoryListViewAdapter extends ConsumerWidget {
  final List<SubCategory?>? subcategories;

  const SubCategoryListViewAdapter({super.key, required this.subcategories});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SubCategoryListView(
      subcategories: subcategories,

      // AÇÃO: Deletar (Usa o Riverpod)
      onDelete: (subCategory) {
        ref
            .read(subCategoryControllerProvider.notifier)
            .deleteSubCategory(subCategory);
      },

      // AÇÃO: Editar (Usa o Service Locator e abre Dialog)
      onEdit: (subCategory) {
        showDialog(
          context: context,
          builder: (context) {
            return ServiceLocator.instance
                .get<ISubCategoryFactory>()
                .createForm(subcategory: subCategory);
          },
        );
      },

      // AÇÃO: Arquivar (Opcional)
      onArchive: (subCategory) {
        // ref.read(...).archive(...)
      },
    );
  }
}
