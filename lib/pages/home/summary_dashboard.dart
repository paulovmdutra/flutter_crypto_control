import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/shared/utils/utils.dart';
import 'package:flutter_crypto_control/widgets/summary_card.dart';
import 'dart:math';
import 'package:flutter_crypto_control/widgets/widgets.dart';

class SummaryDashboard extends StatelessWidget {
  // Dados de exemplo para seus cards
  final List<Map<String, dynamic>> cardData = const [
    {
      'title': 'Servicemen',
      'value': '34',
      'icon': Icons.build,
      'color': Colors.deepPurple,
      'percentage': 3400.00,
      'chartData': [10.0, 15.0, 8.0, 18.0, 14.0, 16.0, 20.0],
    },
    {
      'title': 'Clients',
      'value': '128',
      'icon': Icons.people,
      'color': Colors.blue,
      'percentage': 12.50,
      'chartData': [10.0, 15.0, 8.0, 18.0, 14.0, 16.0, 20.0],
    },
    {
      'title': 'Revenue',
      'value': '\$5.2k',
      'icon': Icons.attach_money,
      'color': Colors.orange,
      'percentage': -5.15,
      'chartData': [10.0, 15.0, 8.0, 18.0, 14.0, 16.0, 20.0],
    },
    {
      'title': 'Projects',
      'value': '45',
      'icon': Icons.folder,
      'color': Colors.teal,
      'percentage': 8.90,
      'chartData': [10.0, 15.0, 8.0, 18.0, 14.0, 16.0, 20.0],
    },
    {
      'title': 'Projects',
      'value': '45',
      'icon': Icons.folder,
      'color': Colors.teal,
      'percentage': 8.90,
      'chartData': [10.0, 15.0, 8.0, 18.0, 14.0, 16.0, 20.0],
    },
    {
      'title': 'Projects',
      'value': '45',
      'icon': Icons.folder,
      'color': Colors.teal,
      'percentage': 8.90,
      'chartData': [10.0, 15.0, 8.0, 18.0, 14.0, 16.0, 20.0],
    },
    {
      'title': 'Projects',
      'value': '45',
      'icon': Icons.folder,
      'color': Colors.teal,
      'percentage': 8.90,
      'chartData': [10.0, 15.0, 8.0, 18.0, 14.0, 16.0, 20.0],
    },

    // Adicione mais cards aqui
  ];

  const SummaryDashboard({super.key});
  @override
  Widget build(BuildContext context) {
    //Obtém o tamanho de tela
    var size = MediaQuery.of(context).size;

    //Define a largura mínima para cada card
    double maxCardWidth = 250.0;
    double minCardWidth = 250.0;

    //Calcula o número de colunas
    int crossAxisCount = (size.width / minCardWidth).floor();

    // Calcula a largura real dos Cards dentro do intervalo especificado
    double cardWidth = size.width / crossAxisCount;
    if (cardWidth > maxCardWidth) {
      crossAxisCount = (size.width / maxCardWidth).floor();
      cardWidth = size.width / crossAxisCount;
    }

    crossAxisCount = max(2, crossAxisCount);

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("Resumo", style: AppTextStyles.headline1)],
            ),
          ),
          SummaryWidget(),
          const SizedBox(height: 20),
          _buildBalanceCard(context, 12500.00, 32000.00, 44500.00),
          const SizedBox(height: 20),
          _buildExpenseChart(context),
          const SizedBox(height: 20),

          _buildQuickActions(context),
          SizedBox(
            child: createGridView(crossAxisCount, cardWidth, maxCardWidth),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Ações Rápidas',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildActionButton(
                  context,
                  Icons.add_circle,
                  'Nova Transação',
                  () => print('Abrir tela de nova transação'),
                ),
                _buildActionButton(
                  context,
                  Icons.money,
                  'Novo Investimento',
                  () => print('Abrir tela de novo investimento'),
                ),
                _buildActionButton(
                  context,
                  Icons.receipt,
                  'Registrar Fatura',
                  () => print('Registrar pagamento de fatura'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    IconData icon,
    String label,
    VoidCallback onPressed,
  ) {
    return Column(
      children: [
        FilledButton.tonal(
          onPressed: onPressed,
          style: FilledButton.styleFrom(
            minimumSize: const Size(60, 60),
            shape: const CircleBorder(),
          ),
          child: Icon(icon, size: 30),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildBalanceCard(
    BuildContext context,
    double balance,
    double investments,
    double netWorth,
  ) {
    final theme = Theme.of(context);
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Patrimônio Líquido Total',
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              currencyFormatter.format(netWorth),
              style: theme.textTheme.displaySmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.netWorth,
              ),
            ),
            const Divider(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildMetric(theme, 'Saldo em Contas', balance, Colors.green),
                _buildMetric(
                  theme,
                  'Investimentos',
                  investments,
                  AppColors.investment,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetric(
    ThemeData theme,
    String title,
    double value,
    Color color,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          currencyFormatter.format(value),
          style: theme.textTheme.titleMedium?.copyWith(color: color),
        ),
      ],
    );
  }

  Widget _buildExpenseChart(BuildContext context) {
    // Simulação de dados para o gráfico de despesas (Mock)
    final double moradia =
        100.00; //controller.state.where((t) => t.category == 'Moradia').fold(0.0, (sum, t) => sum + t.amount);
    final double alimentacao =
        120.00; //controller.state.where((t) => t.category == 'Alimentação').fold(0.0, (sum, t) => sum + t.amount);
    final double outros =
        250.00; //controller.totalExpense - moradia - alimentacao; // O restante

    final barGroups = [
      BarChartGroupData(
        x: 0,
        barRods: [BarChartRodData(toY: moradia, color: AppColors.expense)],
      ),
      BarChartGroupData(
        x: 1,
        barRods: [BarChartRodData(toY: alimentacao, color: Colors.blueAccent)],
      ),
      BarChartGroupData(
        x: 2,
        barRods: [BarChartRodData(toY: outros, color: Colors.orange)],
      ),
    ];

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Despesas por Categoria (Out)',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 200,
              child: BarChart(
                BarChartData(
                  barGroups: barGroups,
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          const titles = ['Moradia', 'Alim.', 'Outros'];
                          return Center(child: Text("")); /*SideTitleWidget(
                            ax: meta.axisSide,
                            child: Text(titles[value.toInt()]),
                          );*/
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  gridData: FlGridData(show: false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget createGridView(
    int crossAxisCount,
    double cardWidth,
    double maxCardWidth,
  ) {
    return GridView.builder(
      padding: const EdgeInsets.all(8),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisExtent: maxCardWidth,
        childAspectRatio: cardWidth / maxCardWidth,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
      ),
      itemCount: cardData.length,
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final data = cardData[index];
        return InkWell(
          onTap: () {},
          child: SummaryCard(
            title: data['title'] as String,
            value: data['value'] as String,
            icon: data['icon'] as IconData,
            iconColor: data['color'] as Color,
            percentageChange: data['percentage'] as double,
            chartData: data['chartData'] as List<double>,
          ),
        );
      },
    );
  }
}

class SummaryWidget extends StatelessWidget {
  const SummaryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Resumo Geral',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Saldo total
          Card(
            child: ListTile(
              title: const Text('Saldo Consolidado'),
              subtitle: const Text('R\$ 82.430,55'),
              trailing: const Icon(Icons.account_balance_wallet_outlined),
            ),
          ),

          const SizedBox(height: 20),
          const Text(
            'Distribuição de Gastos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Gráfico de pizza (gastos por categoria)
          SizedBox(
            height: 250,
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 40,
                    title: 'Habitação',
                    color: Colors.blueAccent,
                    radius: 50,
                  ),
                  PieChartSectionData(
                    value: 25,
                    title: 'Alimentação',
                    color: Colors.greenAccent,
                    radius: 50,
                  ),
                  PieChartSectionData(
                    value: 15,
                    title: 'Lazer',
                    color: Colors.orangeAccent,
                    radius: 50,
                  ),
                  PieChartSectionData(
                    value: 20,
                    title: 'Outros',
                    color: Colors.purpleAccent,
                    radius: 50,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),
          const Text(
            'Evolução Patrimonial (Últimos 6 meses)',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Gráfico de linha (evolução patrimonial)
          SizedBox(
            height: 250,
            child: LineChart(
              LineChartData(
                titlesData: FlTitlesData(
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const months = [
                          'Jun',
                          'Jul',
                          'Ago',
                          'Set',
                          'Out',
                          'Nov',
                        ];
                        return Text(months[value.toInt() % months.length]);
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, interval: 20000),
                  ),
                ),
                gridData: FlGridData(show: true),
                borderData: FlBorderData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 42000),
                      FlSpot(1, 46000),
                      FlSpot(2, 52000),
                      FlSpot(3, 61000),
                      FlSpot(4, 71000),
                      FlSpot(5, 82430),
                    ],
                    isCurved: true,
                    barWidth: 3,
                    color: Colors.blue,
                    dotData: const FlDotData(show: false),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 30),
          const Text(
            'Resumo de Investimentos',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),

          // Lista de investimentos simulados
          Card(
            child: Column(
              children: const [
                ListTile(
                  leading: Icon(Icons.trending_up, color: Colors.green),
                  title: Text('Ações e Fundos'),
                  subtitle: Text('Lucro: R\$ 3.200,00 (12%)'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(Icons.currency_bitcoin, color: Colors.orange),
                  title: Text('Criptomoedas'),
                  subtitle: Text('Lucro: R\$ 1.850,00 (9%)'),
                ),
                Divider(height: 1),
                ListTile(
                  leading: Icon(
                    Icons.account_balance,
                    color: Colors.blueAccent,
                  ),
                  title: Text('Renda Fixa'),
                  subtitle: Text('Lucro: R\$ 1.100,00 (7%)'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
