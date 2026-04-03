import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/account.dart';
import 'package:flutter_crypto_control/domain/models/transaction.dart';
import 'package:flutter_crypto_control/pages/home/transaction_page.dart';
import 'package:flutter_crypto_control/pages/providers/category_providers.dart';
import 'package:flutter_crypto_control/pages/transaction/transaction_form_dialog.dart';
import 'package:flutter_crypto_control/shared/utils/utils.dart';
import 'package:flutter_crypto_control/widgets/confirmation_dialog.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionListTile extends ConsumerWidget {
  final Transaction transaction;
  final Account? currentAccount;
  const TransactionListTile({
    super.key,
    required this.transaction,
    this.currentAccount,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Busca a categoria para obter nome, cor e ícone
    final categoryController = ref.watch(categoryControllerProvider.notifier);
    final category = categoryController.getCategoryById(transaction.categoryId);

    final color = transaction.type == TransactionType.income
        ? AppColors.income
        : AppColors.expense;
    final sign = transaction.type == TransactionType.income ? '+' : '-';

    return ListTile(
      onTap: () {
        // Abre o diálogo de formulário para edição
        showDialog(
          context: context,
          builder: (context) =>
              TransactionFormDialog(transactionToEdit: transaction),
        );
      },
      leading: CircleAvatar(
        backgroundColor: category?.color.withAlpha(50) ?? color.withAlpha(50),
        child: Icon(
          category?.iconCodePoint ?? Icons.help_outline,
          color: category?.color ?? color,
        ),
      ),
      title: Text(
        transaction.description,
        style: const TextStyle(fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        '${category?.name ?? 'Categoria Desconhecida'} | ${dateFormatter.format(transaction.date)}',
        style: const TextStyle(fontSize: 12),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$sign ${currencyFormatter.format(transaction.amount)}',
            style: TextStyle(color: color, fontWeight: FontWeight.bold),
          ),
          // Botão de exclusão (com confirmação)
          IconButton(
            icon: const Icon(
              Icons.delete_outline,
              size: 20,
              color: Colors.grey,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => ConfirmationDialog(
                  title: 'Confirmar Exclusão',
                  content:
                      'Tem certeza de que deseja excluir a transação "${transaction.description}"?',
                  onConfirm: () {
                    ref
                        .read(financialControllerProvider.notifier)
                        .deleteTransaction(transaction);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
