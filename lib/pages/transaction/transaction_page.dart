import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/transaction.dart';
import 'package:flutter_crypto_control/pages/home/transaction_page.dart';
import 'package:flutter_crypto_control/pages/providers/category_providers.dart';
import 'package:flutter_crypto_control/pages/transaction/transaction_form_dialog.dart';
import 'package:flutter_crypto_control/pages/transaction/transaction_list_tile.dart';
import 'package:flutter_crypto_control/shared/utils/utils.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TransactionsPage extends ConsumerWidget {
  const TransactionsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(transactionRepositoryProvider);

    void showAddTransactionDialog() {
      showDialog(
        context: context,
        builder: (context) => TransactionFormDialog(transactionToEdit: null),
      );
    }

    final transactions = ref.watch(financialControllerProvider);
    final totalIncome = ref
        .watch(financialControllerProvider.notifier)
        .totalIncome;
    final totalExpense = ref
        .watch(financialControllerProvider.notifier)
        .totalExpense;

    return Scaffold(
      appBar: AppBar(title: const Text('Transações'), centerTitle: true),
      floatingActionButton: FloatingActionButton.extended(
        heroTag:
            "fab_aba_4", // Disables the Hero animation entirely for this button
        onPressed: showAddTransactionDialog,
        icon: const Icon(Icons.add),
        label: const Text('Nova Transação'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildCardWidget(
                  context,
                  'Receitas',
                  totalIncome,
                  color: AppColors.income,
                ),
                _buildCardWidget(
                  context,
                  'Despesas',
                  totalExpense,
                  color: AppColors.expense,
                ),
              ],
            ),
          ),
          Expanded(
            child: FutureBuilder(
              future: repo.getAllAsync(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                var data = List<Transaction>() = [];
                final List<Transaction?> txs = snapshot.data != null
                    ? snapshot.data!.data!
                    : data;

                if (txs.isEmpty) {
                  return const Center(
                    child: Text('Nenhuma transação registrada ainda.'),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: txs.length,
                  itemBuilder: (context, index) {
                    final tx = txs[index];
                    final color = tx!.type == TransactionType.income
                        ? Colors.green
                        : tx.type == TransactionType.expense
                        ? Colors.red
                        : Colors.blue;

                    return TransactionListTile(transaction: tx); /*Card(
                      elevation: 3,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: color.withOpacity(0.15),
                          child: Icon(
                            tx.type == TransactionType.income
                                ? Icons.arrow_downward
                                : tx.type == TransactionType.expense
                                ? Icons.arrow_upward
                                : Icons.swap_horiz,
                            color: color,
                          ),
                        ),
                        title: Text(tx.description),
                        subtitle: Text(
                          '${tx.categoryId} • ${tx.date.toLocal().toString().split(' ').first}',
                        ),
                        trailing: Text(
                          'R\$ ${tx.amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        onTap: () => _showTransactionForm(
                          context,
                          ref,
                          repo,
                          existing: tx,
                        ),
                        onLongPress: () async {
                          final confirm = await showDialog<bool>(
                            context: context,
                            builder: (ctx) => AlertDialog(
                              title: const Text('Excluir Transação'),
                              content: const Text(
                                'Tem certeza que deseja excluir esta transação?',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, false),
                                  child: const Text('Cancelar'),
                                ),
                                TextButton(
                                  onPressed: () => Navigator.pop(ctx, true),
                                  child: const Text('Excluir'),
                                ),
                              ],
                            ),
                          );
                          if (confirm == true) {
                            await repo.delete(tx.id);
                            // ignore: use_build_context_synchronously
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Transação excluída!'),
                              ),
                            );
                            // força rebuild
                            (context as Element).reassemble();
                          }
                        },
                      ),
                    );*/
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCardWidget(
    BuildContext context,
    String title,
    double value, {
    Color? color,
  }) {
    return Card(
      elevation: 8,
      color: color ?? AppColors.accent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: 250,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.credit_card, size: 40, color: Colors.white),
            const SizedBox(height: 15),
            Text(
              title,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 25),
            Text(
              'VALOR TOTAL',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.white70),
            ),
            Text(
              currencyFormatter.format(value),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _summaryBox(
    BuildContext context,
    String title,
    double value,
    Color color,
  ) {
    return Card(
      color: color.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Text(title, style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              currencyFormatter.format(value),
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
