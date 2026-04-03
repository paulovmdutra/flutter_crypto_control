import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/pages/app/apps.dart';
// Removemos as importações específicas do seu domínio
// import 'package:flutter_crypto_control/domain/models/sub_category.dart';
// import 'package:flutter_crypto_control/pages/subcategory/subcategory_list_tile.dart';

// Definimos um tipo para a função que construirá cada item da lista
typedef ItemWidgetBuilder<T> =
    Widget Function(BuildContext context, T item, int index);

/// Um widget de lista genérico que gerencia um ListModel interno e usa um
/// builder externo para renderizar cada linha.
/// <T> é o tipo de dado que esta lista vai exibir (ex: SubCategory, Transaction, Client).
class GenericListView<T> extends StatefulWidget {
  // A lista bruta de dados
  final List<T?>? items;

  // A função que o pai deve fornecer para dizer COMO desenhar cada item.
  // Substitui o uso fixo do SubCategoryListTile.
  final ItemWidgetBuilder<T> itemBuilder;

  final EdgeInsetsGeometry padding;
  final ScrollPhysics? physics;

  const GenericListView({
    super.key,
    required this.items,
    required this.itemBuilder,
    this.padding = const EdgeInsets.all(12),
    this.physics = const NeverScrollableScrollPhysics(),
  });

  @override
  State<GenericListView<T>> createState() => _GenericListViewState<T>();
}

class _GenericListViewState<T> extends State<GenericListView<T>> {
  // O ListModel agora usa o tipo genérico T.
  // ATENÇÃO: Sua classe ListModel no outro arquivo DEVE suportar generics <T>.
  ListModel<T?>? itemProvider;

  @override
  void initState() {
    super.initState();
    _initListModel();
  }

  @override
  void didUpdateWidget(covariant GenericListView<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Se a lista externa mudou, recriamos o model
    if (widget.items != oldWidget.items) {
      _initListModel();
    }
  }

  void _initListModel() {
    // Assumindo que o construtor do seu ListModel aceita a lista tipada
    itemProvider = ListModel<T?>(items: widget.items?.toList() ?? []);
    itemProvider!.init();
  }

  @override
  Widget build(BuildContext context) {
    if (itemProvider == null) return const SizedBox();

    return ListenableBuilder(
      listenable: itemProvider!,
      builder: (context, child) {
        // Filtramos nulos para segurança antes de passar para o builder
        final validItems = itemProvider!.filteredResults
            .whereType<T>()
            .toList();

        return ListView.builder(
          shrinkWrap: true,
          physics: widget.physics, // Usando o parâmetro do widget
          padding: widget.padding, // Usando o parâmetro do widget
          itemCount: validItems.length,
          itemBuilder: (context, index) {
            final item = validItems[index];

            // Aqui está a mágica da generalização:
            // Não usamos mais SubCategoryListTile diretamente.
            // Chamamos a função builder fornecida pelo pai para desenhar o item.
            return widget.itemBuilder(context, item, index);
          },
        );
      },
    );
  }
}
