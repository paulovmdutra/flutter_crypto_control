import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/entities.dart';
import 'package:flutter_crypto_control/view_model/category_view_model.dart';

/// Interface para a fábrica de páginas de subcategorias
/// Cada método é responsável por criar um tipo específico de página relacionada a subcategorias, como formulários, páginas principais e listas. As implementações concretas dessas fábricas serão responsáveis por fornecer a lógica e os widgets específicos para cada tipo de página, garantindo uma separação clara entre a definição da interface e a implementação real das páginas.
abstract class ISubCategoryFactory {
  Widget createForm({
    SubCategory? subcategory,
    CategoryViewModel? category,
    List<CategoryViewModel?>? categories,
  });
  Widget createContainerMainPage({List<SubCategory?>? subcategories});
  Widget createlListView({List<SubCategory?>? subcategories});
}

/// Interface para a fábrica de páginas de transações
/// Cada método é responsável por criar um tipo específico de página relacionada a transações, como formulários, páginas principais e listas. As implementações concretas dessas fábricas serão responsáveis por fornecer a lógica e os widgets específicos para cada tipo de página, garantindo uma separação clara entre a definição da interface e a implementação real das páginas.
abstract class ICategoryFactory {
  Widget createForm({CategoryViewModel? category});
  Widget createContainerMainPage({List<CategoryViewModel?>? categories});
  Widget createlListView({List<CategoryViewModel?>? categories});
}

/// Interface para a fábrica de páginas de carteiras
/// Cada método é responsável por criar um tipo específico de página relacionada a carteiras, como formulários, páginas principais e listas. As implementações concretas dessas fábricas serão responsáveis por fornecer a lógica e os widgets específicos para cada tipo de página, garantindo uma separação clara entre a definição da interface e a implementação real das páginas.
abstract class IWalletFactory {
  Widget createForm({Wallet? wallet});
  Widget createContainerMainPage({List<Wallet?>? wallets});
  Widget createlListView({List<Wallet?>? wallets});
}
