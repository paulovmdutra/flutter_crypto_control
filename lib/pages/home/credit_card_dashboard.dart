// 5. Tela de Cartões de Crédito
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/credit_card.dart';
import 'package:flutter_crypto_control/shared/utils/utils.dart';

import 'package:flutter_crypto_control/widgets/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:intl/intl.dart';

class CreditCardScreen extends ConsumerWidget {
  const CreditCardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    /*final card = ref
        .watch(financialControllerProvider.notifier)
        .getCreditCardData();*/

    var card = CreditCard(
      id: 1,
      name: "Visa Gold",
      limit: 5000.0,
      currentBalance: 3200.0,
      closingDate: DateTime.now().add(const Duration(days: 10)),
      paymentDate: DateTime.now().add(const Duration(days: 25)),
    );

    final remainingLimit = card.limit - card.currentBalance;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Cartões de Crédito',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 10),
          _buildCreditCardWidget(context, card),
          const SizedBox(height: 20),
          _buildInfoTile(
            context,
            Icons.calendar_today,
            'Fechamento',
            DateFormat('dd/MM/yyyy').format(card.closingDate),
          ),
          _buildInfoTile(
            context,
            Icons.payment,
            'Vencimento',
            DateFormat('dd/MM/yyyy').format(card.paymentDate),
          ),
          const SizedBox(height: 20),
          _buildLimitIndicator(context, card.limit, remainingLimit),
          const SizedBox(height: 20),
          _buildExpenseAlerts(context),
        ],
      ),
    );
  }

  Widget _buildCreditCardWidget(BuildContext context, CreditCard card) {
    return Card(
      elevation: 8,
      color: AppColors.accent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        padding: const EdgeInsets.all(20),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(Icons.credit_card, size: 40, color: Colors.white),
            const SizedBox(height: 15),
            Text(
              card.name,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 25),
            Text(
              'FATURA ATUAL',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.white70),
            ),
            Text(
              currencyFormatter.format(card.currentBalance),
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

  Widget _buildInfoTile(
    BuildContext context,
    IconData icon,
    String title,
    String value,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary),
      title: Text(title, style: Theme.of(context).textTheme.titleMedium),
      trailing: Text(
        value,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildLimitIndicator(
    BuildContext context,
    double limit,
    double remainingLimit,
  ) {
    final usedPercentage = ((limit - remainingLimit) / limit);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Limite Total: ${currencyFormatter.format(limit)}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: usedPercentage,
                minHeight: 15,
                backgroundColor: Colors.grey.shade300,
                color: usedPercentage > 0.7
                    ? AppColors.expense
                    : AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Limite Disponível: ${currencyFormatter.format(remainingLimit)}',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppColors.income),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExpenseAlerts(BuildContext context) {
    return Card(
      color: Colors.red.shade50,
      child: const ListTile(
        leading: Icon(Icons.warning, color: AppColors.expense),
        title: Text(
          'Alerta de Gastos',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: AppColors.expense,
          ),
        ),
        subtitle: Text(
          'Sua despesa em "Alimentação" ultrapassou 80% do seu limite mensal.',
        ),
      ),
    );
  }
}
