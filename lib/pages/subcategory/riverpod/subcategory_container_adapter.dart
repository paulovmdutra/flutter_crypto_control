import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/pages/ipages_factory.dart';
import 'package:flutter_crypto_control/pages/models_page.dart';
import 'package:flutter_crypto_control/pages/providers/subcategory_providers.dart';
import 'package:flutter_crypto_control/pages/subcategory/riverpod/form_widget_adapter.dart';
import 'package:flutter_crypto_control/pages/subcategory/subcategory_internal_page.dart';
import 'package:flutter_crypto_control/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubCategoryContainerAdapter extends ConsumerWidget {
  const SubCategoryContainerAdapter({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Observa o estado com Riverpod
    final controllerAsync = ref.watch(subCategoryControllerProvider);

    // 2. Transforma o estado do Riverpod para o formato esperado pelo SubCategoryPage
    final state = controllerAsync.toViewAsync();

    // Ação de Recarregar
    final VoidCallback onReload = () {
      ref.read(subCategoryControllerProvider.notifier).loadCategories();
    };

    // Ação de Adicionar (inclui a navegação e a lógica do form)
    final VoidCallback onAddCategory = () {
      // Assumindo que você tem uma maneira de buscar todas as categorias aqui
      // (Isso é necessário para o SubCategoryFormDialog, como definimos antes)
      // A lógica para abrir o FormCaller ou SubCategoryFormDialog deve estar aqui.

      // Se você decidir que FormCaller é o ponto de entrada para o diálogo,
      // ele precisaria ser um ConsumerWidget ou receber o ref.
      showDialog(
        context: context,
        builder: (context) {
          // Usa a fábrica genérica para criar o form sem acoplar
          return ServiceLocator.instance
              .get<ISubCategoryFactory>()
              .createForm();
        },
      );
    };

    // Preparação dos dados para injeção (apenas se o estado for de dados)
    SubCategoryModel categoryModel;
    if (controllerAsync.hasValue) {
      categoryModel = SubCategoryModel(
        entities: controllerAsync.requireValue.data ?? [],
      );
    } else {
      // Fornece um modelo vazio ou lida com o estado de loading/erro
      categoryModel = SubCategoryModel(entities: []);
    }

    // 3. Injeta o estado e as ações no widget de UI independente
    var m = SubCategoryInternalPage(
      state: state,
      categoryModel: categoryModel,
      onAddCategory: onAddCategory,
      onReload: onReload,
    );
    return m;
  }
}
