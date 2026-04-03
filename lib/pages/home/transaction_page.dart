// Notifier para o estado financeiro (Transações)
import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/monthly_summary.dart';
import 'package:flutter_crypto_control/domain/models/transaction.dart';
import 'package:flutter_crypto_control/domain/repositories/itransactionrepository.dart';
import 'package:flutter_crypto_control/domain/repositories/repository.dart';
import 'package:flutter_crypto_control/infra/fake/in_memory_transaction_repository.dart';
import 'package:flutter_crypto_control/pages/providers/category_providers.dart';
import 'package:flutter_crypto_control/pages/transaction/transaction_form_dialog.dart';
import 'package:flutter_crypto_control/pages/transaction/transaction_list_tile.dart';
import 'package:flutter_crypto_control/shared/utils/utils.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:intl/intl.dart';

// Formatador de data
final dateFormatter = DateFormat('dd/MM/yyyy');

// ENUM para o Filtro de Período
enum TimePeriodFilter {
  threeMonths(3, '3 Meses'),
  sixMonths(6, '6 Meses'),
  twelveMonths(12, '12 Meses');

  final int months;
  final String label;
  const TimePeriodFilter(this.months, this.label);
}

class FinancialController extends StateNotifier<List<Transaction?>> {
  final IRepository<Transaction> _repository;
  FinancialController(this._repository) : super([]);

  Future<void> loadTransactions() async {
    var data = await _repository.getAllAsync();
    state = data.data!;
  }

  // NOVOS MÉTODOS DE CRUD
  void addTransaction(Transaction newTransaction) async {
    await _repository.addAsync(newTransaction);
    await loadTransactions();
  }

  void updateTransaction(Transaction updatedTransaction) async {
    await _repository.updateAsync(updatedTransaction);
    await loadTransactions();
  }

  void deleteTransaction(Transaction transactionId) async {
    await _repository.deleteAsync(transactionId);
    await loadTransactions();
  }

  // Métricas
  double get totalIncome => state
      .where((t) => t!.type == TransactionType.income)
      .fold(0.0, (sum, t) => sum + t!.amount);
  double get totalExpense => state
      .where((t) => t!.type == TransactionType.expense)
      .fold(0.0, (sum, t) => sum + t!.amount);
  double get currentBalance => totalIncome - totalExpense;

  // Dados para o Gráfico
  List<MonthlySummary> getMonthlyIncomeExpenseData(TimePeriodFilter filter) {
    if (state.isEmpty) return [];

    final now = DateTime.now();
    final sortedMonths = <String>[];

    for (int i = filter.months - 1; i >= 0; i--) {
      final month = DateTime(now.year, now.month - i, 1);
      sortedMonths.add(DateFormat('yyyy-MM').format(month));
    }

    final monthlyData = <MonthlySummary>[];
    for (int i = 0; i < sortedMonths.length; i++) {
      final key = sortedMonths[i];
      final monthStart = DateTime.parse('${key}-01');
      final monthEnd = DateTime(monthStart.year, monthStart.month + 1, 0);

      final monthTransactions = state
          .where(
            (tx) =>
                tx!.date.isAfter(
                  monthStart.subtract(const Duration(days: 1)),
                ) &&
                tx.date.isBefore(monthEnd.add(const Duration(days: 1))),
          )
          .toList();

      final totalIncome = monthTransactions
          .where((t) => t!.type == TransactionType.income)
          .fold(0.0, (sum, t) => sum + t!.amount);

      final totalExpense = monthTransactions
          .where((t) => t!.type == TransactionType.expense)
          .fold(0.0, (sum, t) => sum + t!.amount);

      final monthLabel = DateFormat('MMM/yy', 'pt_BR').format(monthStart);

      monthlyData.add(
        MonthlySummary(
          monthYear: monthLabel,
          totalIncome: totalIncome,
          totalExpense: totalExpense,
          monthIndex: i,
        ),
      );
    }
    return monthlyData;
  }
}

final financialControllerProvider =
    StateNotifierProvider<FinancialController, List<Transaction?>>((ref) {
      final repository = ref.watch(transactionRepositoryProvider);
      final controller = FinancialController(repository);
      controller.loadTransactions(); // Carrega os dados iniciais
      return controller;
    });

final timePeriodFilterProvider = StateProvider<TimePeriodFilter>(
  (ref) => TimePeriodFilter.sixMonths,
);

class TransactionPageScreen extends ConsumerWidget {
  const TransactionPageScreen({super.key});

  Widget _buildBalanceCard(BuildContext context, double balance) {
    final isPositive = balance >= 0;
    final theme = Theme.of(context);

    return Card(
      color: theme.colorScheme.surfaceVariant,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Saldo Atual',
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              currencyFormatter.format(balance),
              style: theme.textTheme.headlineMedium?.copyWith(
                color: isPositive ? AppColors.income : AppColors.expense,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = ref.watch(financialControllerProvider.notifier);
    final transactions = ref.watch(financialControllerProvider);
    final theme = Theme.of(context);

    // Ordena as transações para mostrar as mais recentes
    final recentTransactions = transactions.toList()
      ..sort((a, b) => b!.date.compareTo(a!.date));

    void showAddTransactionDialog() {
      showDialog(
        context: context,
        builder: (context) =>
            const TransactionFormDialog(transactionToEdit: null),
      );
    }

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Painel de Controle', style: theme.textTheme.headlineLarge),
            const SizedBox(height: 20),

            // Cartão de Saldo
            _buildBalanceCard(context, controller.currentBalance),
            const SizedBox(height: 20),

            // Gráfico de Tendência Mensal
            //const IncomeExpenseLineChart(),
            const SizedBox(height: 20),

            // Transações Recentes
            Text('Transações Recentes', style: theme.textTheme.titleLarge),
            const SizedBox(height: 10),

            Card(
              elevation: 2,
              child: Column(
                children: recentTransactions
                    .take(5)
                    .map((tx) => TransactionListTile(transaction: tx!))
                    .toList(),
              ),
            ),
            const SizedBox(height: 60), // Espaço para o FAB
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: showAddTransactionDialog,
        heroTag:
            "fab_aba_2", // Disables the Hero animation entirely for this button
        icon: const Icon(Icons.add),
        label: const Text('Nova Transação'),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
    );
  }
}
