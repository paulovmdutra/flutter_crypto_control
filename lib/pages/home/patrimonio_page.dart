import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/shared/utils/utils.dart';
import 'package:flutter_crypto_control/widgets/app_colors.dart';
import 'package:flutter_crypto_control/widgets/app_textstyles.dart';

class NetWorthItem {
  final String id;
  final String name;
  final String category; // Imóvel, Veículo, Outros
  final double estimatedValue;

  NetWorthItem({
    required this.id,
    required this.name,
    required this.category,
    required this.estimatedValue,
  });
}

class PatrimonyScreen extends StatefulWidget {
  const PatrimonyScreen({super.key});

  @override
  State<PatrimonyScreen> createState() => _PatrimonyScreenState();
}

class _PatrimonyScreenState extends State<PatrimonyScreen> {
  final mockNetWorth = [
    NetWorthItem(
      id: 'nw1',
      name: 'Apartamento Próprio',
      category: 'Imóvel',
      estimatedValue: 350000.0,
    ),
    NetWorthItem(
      id: 'nw2',
      name: 'Carro',
      category: 'Veículo',
      estimatedValue: 70000.0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final netWorthItems = mockNetWorth;
    final totalNetWorth = 10; //controller.totalNetWorthValue;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gestão de Patrimônio',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 10),
          Card(
            elevation: 4,
            color: AppColors.netWorth.withOpacity(0.1),
            child: ListTile(
              title: Text(
                'Patrimônio Líquido Total Estimado',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              trailing: Text(
                currencyFormatter.format(totalNetWorth),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.netWorth,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Bens Físicos', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 10),
          ...netWorthItems
              .map(
                (item) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: Icon(
                      item.category == 'Imóvel'
                          ? Icons.home
                          : Icons.directions_car,
                      color: AppColors.primary,
                    ),
                    title: Text(item.name),
                    subtitle: Text(item.category),
                    trailing: Text(
                      currencyFormatter.format(item.estimatedValue),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              )
              .toList(),
          const SizedBox(height: 20),
          // Simulação de Gráfico de Evolução Patrimonial (LineChart)
          _buildEvolutionChart(context),
        ],
      ),
    );
  }

  Widget _buildEvolutionChart(BuildContext context) {
    // Mock de dados para evolução do patrimônio (LineChart)
    final spots = [
      FlSpot(0, 300000),
      FlSpot(1, 320000),
      FlSpot(2, 360000),
      FlSpot(3, 410000),
      FlSpot(4, 420000),
    ];
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 24, 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Evolução Patrimonial (Mock)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: 50000,
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const titles = ['Jan', 'Fev', 'Mar', 'Abr', 'Mai'];
                          return Text(titles[value.toInt()]);
                          /*return SideTitleWidget(
                            axisSide: meta.axisSide,
                            child: Text(titles[value.toInt()]),
                          );*/
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 60,
                        getTitlesWidget: (value, meta) {
                          if (value == meta.max) return const Text('R\$');
                          return Text(
                            (value / 1000).toStringAsFixed(0) + 'K',
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      color: AppColors.netWorth,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: AppColors.netWorth.withOpacity(0.3),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
