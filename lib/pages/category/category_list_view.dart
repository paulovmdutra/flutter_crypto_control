import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/pages/app/enums.dart';
import 'package:flutter_crypto_control/pages/app/generic_form/generic_list_tile.dart';
import 'package:flutter_crypto_control/pages/ipages_factory.dart';
import 'package:flutter_crypto_control/service_locator.dart';
import 'package:flutter_crypto_control/widgets/confirmation_dialog.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';

class CategoryListView extends StatefulWidget {
  final List<Category?>? categories;

  // Callbacks para as ações. Quem chamar esse widget decide o que fazer.
  final Function(Category) onEdit;
  final Function(Category) onDelete;
  final Function(Category)? onArchive;
  final Function(Category)? onMove;

  const CategoryListView({
    super.key,
    required this.categories,
    required this.onEdit,
    required this.onDelete,
    this.onArchive,
    this.onMove,
  });

  @override
  State<CategoryListView> createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {
  @override
  Widget build(BuildContext context) {
    return _buildList(context);
  }

  GenericListTile<Category, DefaultActions> createListTile(
    Category categoryItem,
    BuildContext context,
  ) {
    return GenericListTile<Category, DefaultActions>(
      item: categoryItem,
      onTap: () => widget.onEdit(categoryItem),
      buildLeading: (item) {
        return CircleAvatar(
          backgroundColor: item.color.withAlpha(50),
          child: Icon(item.iconCodePoint, color: item.color),
        );
      },
      buildTitle: (item) {
        return Text(
          item.name,
          style: const TextStyle(fontWeight: FontWeight.w500),
        );
      },
      buildTrailingContent: (item) {
        return Row(
          mainAxisSize: MainAxisSize.min, // Ocupa apenas o espaço necessário
          children: [
            // 1. Botão para Incluir Subcategorias
            IconButton(
              icon: const Icon(
                Icons.add_box_outlined,
                color: AppColors.primary,
              ),
              tooltip: 'Incluir Subcategoria',
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return ServiceLocator.instance
                        .get<ISubCategoryFactory>()
                        .createForm(
                          category: item,
                          categories: widget.categories,
                        );
                  },
                );
              },
            ),
          ],
        );
      },
      menuItems: [
        MenuActionItem(
          label: 'Editar',
          icon: Icons.edit,
          value: DefaultActions.edit,
        ),
        MenuActionItem(
          label: 'Arquivar',
          icon: Icons.archive_outlined,
          value: DefaultActions.archive,
        ),
        MenuActionItem(
          label: 'Mover Transações',
          icon: Icons.move_up_outlined,
          value: DefaultActions.moveTransactions,
        ),
        // ----------------------------
        MenuSeparatorItem(),
        // ----------------------------
        MenuActionItem(
          label: 'Excluir',
          icon: Icons.delete_outline,
          value: DefaultActions.delete,
          isDestructive: true, // Isso fará o ícone e texto ficarem vermelhos
        ),
      ],
      // --- 3. Lidando com as ações do menu ---
      onActionSelected: (action, item) {
        switch (action) {
          case DefaultActions.edit:
            widget.onEdit(categoryItem);
            break;

          case DefaultActions.delete:
            showDialog(
              context: context,
              builder: (ctx) => ConfirmationDialog(
                title: 'Confirmar Exclusão',
                content: 'Tem certeza de que deseja excluir "${item.name}"?',
                onConfirm: () {
                  widget.onDelete(categoryItem);
                },
              ),
            );
            break;
          // ... outros cases ...
          case DefaultActions.archive:
            widget.onArchive?.call(categoryItem);
            break;
          case DefaultActions.moveTransactions:
            widget.onMove?.call(categoryItem);
            break;
        }
      },
    );
  }

  Widget _buildList(BuildContext context) {
    return ExpansionTile(
      initiallyExpanded: true,
      tilePadding: EdgeInsets.zero,
      title: Text(
        'Categorias de Receita (${widget.categories!.length})',
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(color: AppColors.income),
      ),
      children: widget.categories!
          .map((c) => createListTile(c!, context))
          .toList(),
    );
  }
}
