import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/application/usecase/service_result.dart';
import 'package:flutter_crypto_control/domain/models/entity.dart';
import 'package:flutter_crypto_control/pages/app/apps.dart';
import 'package:flutter_crypto_control/widgets/dialog_widgets.dart';
import 'package:flutter_crypto_control/widgets/search_field.dart';

typedef FilterFunction<E> = bool Function(E item);
typedef EntityTapCallback<E> = Future<void> Function(E entity);
typedef DeleteEntityCallback<E> = Future<ServiceResult> Function(E entity);
typedef FieldBuilder<E> = String Function(E item);

class GenericSearchScreen<E extends Entity<E>> extends StatefulWidget {
  final String title;
  final Future<List<E>> Function() onLoadItems;
  final EntityTapCallback<E> onTapItem;
  final DeleteEntityCallback<E> onDeleteItem;
  final Map<String, FieldBuilder<E>> searchableFields;
  final Widget Function(E entity, int index, GenericSearchScreenState<E> state)?
  itemBuilder;
  final Widget Function(E entity)? titleBuilder;

  const GenericSearchScreen({
    super.key,
    required this.title,
    required this.onLoadItems,
    required this.onTapItem,
    required this.onDeleteItem,
    required this.searchableFields,
    this.itemBuilder,
    this.titleBuilder,
  });

  @override
  State<GenericSearchScreen<E>> createState() => GenericSearchScreenState<E>();
}

class GenericSearchScreenState<E extends Entity<E>>
    extends State<GenericSearchScreen<E>> {
  final TextEditingController _searchController = TextEditingController();
  final ListModel<E> itemProvider = ListModel(items: List.empty());

  String currentSearchField = "";
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    currentSearchField = widget.searchableFields.keys.first;
    _loadItems();
  }

  Future<void> _loadItems() async {
    setState(() => isLoading = true);
    final items = await widget.onLoadItems();
    setState(() {
      itemProvider.items = items;
      itemProvider.init();
      isLoading = false;
    });
  }

  void _onSearchChanged(String value) async {
    if (value.isEmpty) {
      itemProvider.resetFilter();
    } else {
      final fieldGetter = widget.searchableFields[currentSearchField];
      if (fieldGetter != null) {
        await itemProvider.filterBy(
          (item) => fieldGetter(
            item,
          ).toString().toLowerCase().contains(value.toLowerCase()),
        );
      }
    }
  }

  Future<void> confirmDelete(int index) async {
    await _confirmDelete(index);
  }

  Future<void> _confirmDelete(int index) async {
    final confirmed = await showConfirmDialog(
      context,
      title: "Excluir Item",
      content: "Você tem certeza que deseja excluir este item?",
    );
    if (confirmed == true) {
      await _deleteItem(index);
    }
  }

  Future<void> _deleteItem(int index) async {
    setState(() => isLoading = true);
    final entity = itemProvider.filteredResults[index];
    final result = await widget.onDeleteItem(entity);
    if (!mounted) return;

    if (!result.success) {
      //   showErrorDialog(result, context);
      setState(() => isLoading = false);
      return;
    }

    setState(() => isLoading = false);

    setState(() {
      if (result.success) {
        itemProvider.removeAt(index);
      }
    });

    if (!mounted) return;

    //await showMessageDialog("Excluído com sucesso", context);

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Item excluído com sucesso")));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: _buildBody(),
      ),
    );
  }

  Padding _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          _buildSearchField(),
          const SizedBox(height: 16),
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : _buildListView(),
        ],
      ),
    );
  }

  Widget _buildSearchRow() {
    return Row(
      children: [
        /*DropdownButton<String>(
          value: currentSearchField,
          onChanged: (value) {
            if (value != null) {
              setState(() => currentSearchField = value);
              _onSearchChanged(_searchController.text);
            }
          },
          items: widget.searchableFields.entries
              .map((e) => DropdownMenuItem(
                    value: e.key,
                    child: Text(e.key),
                  ))
              .toList(),
        ),
        const SizedBox(width: 16),*/
        //_buildSearchField(),
      ],
    );
  }

  Widget _buildSearchField() {
    return SearchField(
      controller: _searchController,
      onChanged: (value) => _onSearchChanged(value),
    );
  }

  Widget _buildListView() {
    var items = itemProvider.filteredResults;

    if (items.isEmpty) {
      return const Text(
        "Nenhum dado encontrado!",
        style: TextStyle(fontSize: 20),
      );
    }

    return Expanded(child: _buildListViewBuilder());
  }

  Widget _buildListViewBuilder() {
    return ListenableBuilder(
      listenable: itemProvider,
      builder: (context, child) {
        return ListView.builder(
          itemCount: itemProvider.filteredResults.length,
          itemBuilder: (context, index) {
            final entity = itemProvider.filteredResults[index];
            return Dismissible(
              key: ValueKey(entity.id),
              direction: DismissDirection.endToStart,
              onDismissed: (_) => _confirmDelete(index),
              confirmDismiss: (direction) async {
                bool confirm = false;
                confirm = (await showConfirmDialog(
                  context,
                  title: "Excluir Item",
                  content: "Você tem certeza que deseja excluir este item?",
                ))!;

                if (confirm) {
                  await _deleteItem(index); // Agora sim exclui
                }
                return false; // Não remova visualmente o item ainda; fazemos isso no _deleteItem()
              },
              background: Container(
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 20),
                child: const Icon(Icons.delete),
              ),
              child: _buildListTile(entity, index),
            );
            //return _buildListTile(entity, index);
          },
        );
      },
    );
  }

  Widget _buildListTile(entity, int index) {
    if (widget.itemBuilder != null) {
      return widget.itemBuilder!(entity, index, this);
    }

    var custom = widget.titleBuilder?.call(entity) ?? Text(entity.toString());

    return ListTile(
      title: custom,
      onTap: () => widget.onTapItem(entity),
      trailing: PopupMenuButton<String>(
        onSelected: (value) {
          if (value == 'Excluir') {
            _confirmDelete(index);
          }
        },
        itemBuilder: (BuildContext context) => [
          const PopupMenuItem<String>(value: 'Excluir', child: Text('Excluir')),
        ],
      ),
    );
  }
}
