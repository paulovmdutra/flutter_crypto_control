// Flutter Finance App - Base Project
// Etapa 4: Mock do Dashboard Analítico com gráficos simulados
// ==================== lib/presentation/screens/dynamic_dashboard.dart ====================
import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/transaction.dart';
import 'package:flutter_crypto_control/pages/providers/category_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'dart:math';

// Provider agregado que busca todas as transações para todas as contas
final allTransactionsProvider = FutureProvider<List<Transaction>>((ref) async {
  final txRepo = ref.watch(transactionRepositoryProvider);
  final List<Transaction> all = [];
  // ordenar por data decrescente
  all.sort((a, b) => b.date.compareTo(a.date));
  return all;
});

class DynamicDashboardScreen extends ConsumerStatefulWidget {
  const DynamicDashboardScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<DynamicDashboardScreen> createState() =>
      _DynamicDashboardScreenState();
}

class _DynamicDashboardScreenState extends ConsumerState<DynamicDashboardScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animController;

  @override
  void initState() {
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _animController.forward();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contextf) {
    final txsAsync = ref.watch(allTransactionsProvider);

    // recent expenses (últimos 30 dias)
    List<Transaction> recentExpenses = [];
    Map<int, double> categoryMap = {};

    txsAsync.whenData((txs) {
      final thirtyDaysAgo = DateTime.now().subtract(const Duration(days: 30));
      recentExpenses = txs
          .where(
            (t) =>
                t.type == TransactionType.expense &&
                t.date.isAfter(thirtyDaysAgo),
          )
          .toList();

      categoryMap.clear();
      for (final t in txs.where((t) => t.type == TransactionType.expense)) {
        categoryMap[t.categoryId] = (categoryMap[t.categoryId] ?? 0) + t.amount;
      }
    });

    // preparar seções para o PieChart
    final pieSections = <PieChartSectionData>[];
    final totalExpenses = categoryMap.values.fold(0.0, (s, v) => s + v);
    int colorSeed = 0;
    categoryMap.forEach((cat, val) {
      final pct = totalExpenses == 0 ? 0 : (val / totalExpenses) * 100;
      final color = Colors.primaries[colorSeed % Colors.primaries.length];
      colorSeed++;
      pieSections.add(
        PieChartSectionData(
          value: val,
          title: '${pct.toStringAsFixed(0)}%',
          radius: 40,
          titleStyle: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          color: color,
        ),
      );
    });

    // construir UI
    return RefreshIndicator(
      onRefresh: () async {
        // força reload dos providers que suportam
        await ref.refresh(allTransactionsProvider.future);
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cards de resumo
            Row(
              children: [
                _buildSummaryCard(
                  'Saldo',
                  'R\$ ${1050.toStringAsFixed(2)}',
                  Icons.account_balance_wallet,
                  Colors.blue,
                ),
                const SizedBox(width: 12),
                _buildSummaryCard(
                  'Investimentos',
                  'R\$ ${10.50.toStringAsFixed(2)}',
                  Icons.trending_up,
                  Colors.green,
                ),
                const SizedBox(width: 12),
                _buildSummaryCard(
                  'Patrimônio',
                  'R\$ ${800.50.toStringAsFixed(2)}',
                  Icons.home,
                  Colors.deepPurple,
                ),
              ],
            ),

            const SizedBox(height: 20),

            // Gráfico de linha - evolução patrimonial (gerado a partir de assets + patrimony)
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Evolução Patrimonial (6 meses)',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 220,
                      child: LineChart(
                        LineChartData(
                          gridData: FlGridData(show: true),
                          borderData: FlBorderData(show: true),
                          titlesData: FlTitlesData(
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (v, meta) {
                                  const months = [
                                    'Jun',
                                    'Jul',
                                    'Aug',
                                    'Sep',
                                    'Oct',
                                    'Nov',
                                  ];
                                  return Text(
                                    months[v.toInt() % months.length],
                                  );
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true),
                            ),
                          ),
                          lineBarsData: [
                            LineChartBarData(
                              spots: _generatePatrimonySpots(0, 0),
                              isCurved: true,
                              barWidth: 3,
                              dotData: FlDotData(show: true),
                              belowBarData: BarAreaData(
                                show: true,
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.blue.withOpacity(0.3),
                                    Colors.transparent,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Pie chart - distribuição de despesas
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Distribuição de Despesas',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 220,
                      child: pieSections.isEmpty
                          ? const Center(
                              child: Text('Sem despesas registradas'),
                            )
                          : PieChart(
                              PieChartData(
                                sections: pieSections,
                                sectionsSpace: 4,
                                centerSpaceRadius: 30,
                              ),
                            ),
                    ),
                    const SizedBox(height: 8),
                    // legenda simples
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: categoryMap.entries
                          .map(
                            (e) => Chip(
                              label: Text(
                                '${e.key}: R\$ ${e.value.toStringAsFixed(2)}',
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Lista de transações recentes
            Card(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Transações Recentes',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    txsAsync.when(
                      data: (txs) => Column(
                        children: txs
                            .take(6)
                            .map(
                              (t) => ListTile(
                                leading: CircleAvatar(
                                  child: Icon(
                                    t.type == TransactionType.income
                                        ? Icons.arrow_downward
                                        : Icons.arrow_upward,
                                  ),
                                ),
                                title: Text(t.description),
                                subtitle: Text(
                                  '${t.categoryId} • ${t.date.toLocal().toString().split(' ').first}',
                                ),
                                trailing: Text(
                                  'R\$ ${t.amount.toStringAsFixed(2)}',
                                  style: TextStyle(
                                    color: t.type == TransactionType.income
                                        ? Colors.green
                                        : Colors.red,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (e, st) =>
                          Center(child: Text('Erro ao carregar transações')),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Expanded(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.12)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: color.withOpacity(0.2),
              child: Icon(icon, color: color),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                  const SizedBox(height: 6),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: Text(
                      value,
                      key: ValueKey(value),
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// gera pontos de exemplo para o gráfico de evolução patrimonial
List<FlSpot> _generatePatrimonySpots(double invested, double patrimony) {
  // cria 6 pontos a partir de invested -> patrimony
  final spots = <FlSpot>[];
  final base = invested + patrimony;
  final rnd = Random(42);
  for (var i = 0; i < 6; i++) {
    final factor = 0.6 + (i / 10) + rnd.nextDouble() * 0.2;
    final value = base * factor / 2; // escala
    spots.add(FlSpot(i.toDouble(), value));
  }
  return spots;
}
