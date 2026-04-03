import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/sub_category.dart';
import 'package:flutter_crypto_control/domain/models/transaction.dart';
import 'package:flutter_crypto_control/pages/app/enums.dart';
import 'package:flutter_crypto_control/pages/app/generic_form/generic_list_tile.dart';
import 'package:flutter_crypto_control/pages/app/generic_form/generic_list_view.dart';
import 'package:flutter_crypto_control/shared/utils/utils.dart';
import 'package:flutter_crypto_control/widgets/confirmation_dialog.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';

class SubCategoryListView extends StatefulWidget {
  final List<SubCategory?>? subcategories;

  // Callbacks para as ações. Quem chamar esse widget decide o que fazer.
  final Function(SubCategory) onEdit;
  final Function(SubCategory) onDelete;
  final Function(SubCategory)? onArchive;
  final Function(SubCategory)? onMove;

  const SubCategoryListView({
    super.key,
    required this.subcategories,
    required this.onEdit,
    required this.onDelete,
    this.onArchive,
    this.onMove,
  });

  @override
  State<SubCategoryListView> createState() => _SubCategoryListViewState();
}

class _SubCategoryListViewState extends State<SubCategoryListView> {
  @override
  Widget build(BuildContext context) {
    return GenericListView<SubCategory>(
      items: widget.subcategories,
      itemBuilder: (context, subcategoryItem, index) {
        return GenericListTile<SubCategory, DefaultActions>(
          item: subcategoryItem,
          onTap: () => widget.onEdit(subcategoryItem),
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
          buildSubtitle: (item) {
            return Text(
              item.categoryName ?? 'Categoria Desconhecida',
              style: const TextStyle(fontSize: 12),
            );
          },
          // Aqui definimos o conteúdo que fica ANTES do menu
          buildTrailingContent: (item) {
            // Lógica específica de domínio para cor e sinal
            final isIncome = item.category!.type == TransactionType.income;
            final color = isIncome ? AppColors.income : AppColors.expense;
            final sign = isIncome ? '+' : '-';
            return Text(
              '$sign ${currencyFormatter.format(item.currentBalance)}',
              style: TextStyle(color: color, fontWeight: FontWeight.bold),
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
              isDestructive:
                  true, // Isso fará o ícone e texto ficarem vermelhos
            ),
          ],
          // --- 3. Lidando com as ações do menu ---
          onActionSelected: (action, item) {
            switch (action) {
              case DefaultActions.edit:
                widget.onEdit(subcategoryItem);
                break;

              case DefaultActions.delete:
                showDialog(
                  context: context,
                  builder: (ctx) => ConfirmationDialog(
                    title: 'Confirmar Exclusão',
                    content:
                        'Tem certeza de que deseja excluir "${item.name}"?',
                    onConfirm: () {
                      widget.onDelete(subcategoryItem);
                    },
                  ),
                );
                break;
              // ... outros cases ...
              case DefaultActions.archive:
                widget.onArchive?.call(subcategoryItem);
                break;
              case DefaultActions.moveTransactions:
                widget.onMove?.call(subcategoryItem);
                break;
            }
          },
        );
      },
    );
  }
}
