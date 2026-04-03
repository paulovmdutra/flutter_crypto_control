import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Certifique-se de adicionar ao pubspec.yaml

void main() {
  runApp(const TestDasdboard());
}

class TestDasdboard extends StatelessWidget {
  const TestDasdboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DashboardPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CategorySummary {
  final String label;
  final double percentage;
  final Color color;

  CategorySummary(this.label, this.percentage, this.color);
}

final List<CategorySummary> categoryData = [
  CategorySummary("Lazer", 15, Colors.blueAccent),
  CategorySummary("Contas", 45, const Color(0xFFFF4D6D)), // Coral
  CategorySummary("Saúde", 20, Colors.purpleAccent),
  CategorySummary("Outros", 20, Colors.grey),
];

class Transaction {
  final String title;
  final String category;
  final double value;
  final DateTime date;
  final IconData icon;
  final bool isIncome;

  Transaction({
    required this.title,
    required this.category,
    required this.value,
    required this.date,
    required this.icon,
    required this.isIncome,
  });
}

// Dados estáticos para popular a UI
final List<Transaction> mockTransactions = [
  Transaction(
    title: 'Supermercado Alpha',
    category: 'Alimentação',
    value: 250.50,
    date: DateTime.now(),
    icon: Icons.shopping_basket_outlined,
    isIncome: false,
  ),
  Transaction(
    title: 'Salário Mensal',
    category: 'Renda',
    value: 5000.00,
    date: DateTime.now().subtract(const Duration(days: 1)),
    icon: Icons.work_outline,
    isIncome: true,
  ),
  Transaction(
    title: 'Assinatura Netflix',
    category: 'Entretenimento',
    value: 55.90,
    date: DateTime.now().subtract(const Duration(days: 2)),
    icon: Icons.play_circle_outline,
    isIncome: false,
  ),
];

// Paleta de Cores Customizada
class FinanceColors {
  static const Color background = Color(0xFF12151C);
  static const Color surface = Color(0xFF1E222D);
  static const Color accentGreen = Color(0xFF50E3C2); // Esmeralda
  static const Color accentPink = Color(0xFFFF4D6D); // Coral/Pink
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFF8E94A4);
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  bool _isBalanceVisible = true;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: FinanceColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 25),
              _buildBalanceCard(size),
              const SizedBox(height: 30),
              _buildQuickActions(),
              const SizedBox(height: 30),
              _buildChartSection(),
              const SizedBox(height: 30),
              _buildTransactionList(),
              const SizedBox(height: 30),
              _buildCategoryChart(), // Novo Gráfico de Barras
              const SizedBox(height: 30),
              _buildComparisonLineChart(), // Novo Gráfico de Linhas
              const SizedBox(height: 30),
              _buildTransactionList(),
            ],
          ),
        ),
      ),
    );
  }

  // 1. Header com Saudação e Perfil
  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Olá, Lucas",
              style: TextStyle(
                color: FinanceColors.textSecondary,
                fontSize: 16,
              ),
            ),
            Text(
              "Bem-vindo de volta!",
              style: TextStyle(
                color: FinanceColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        CircleAvatar(
          backgroundColor: FinanceColors.surface,
          child: const Icon(
            Icons.person_outline,
            color: FinanceColors.accentGreen,
          ),
        ),
      ],
    );
  }

  // 2. Card de Saldo com Toggle de Visibilidade
  Widget _buildBalanceCard(Size size) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            FinanceColors.surface,
            FinanceColors.surface.withOpacity(0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Saldo Total",
                style: TextStyle(color: FinanceColors.textSecondary),
              ),
              IconButton(
                onPressed: () =>
                    setState(() => _isBalanceVisible = !_isBalanceVisible),
                icon: Icon(
                  _isBalanceVisible
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: FinanceColors.textSecondary,
                  size: 20,
                ),
              ),
            ],
          ),
          Text(
            _isBalanceVisible ? "R\$ 12.450,00" : "••••••",
            style: const TextStyle(
              color: FinanceColors.textPrimary,
              fontSize: 32,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              _buildMiniIndicator(
                Icons.arrow_upward,
                "Entradas",
                FinanceColors.accentGreen,
              ),
              const SizedBox(width: 20),
              _buildMiniIndicator(
                Icons.arrow_downward,
                "Saídas",
                FinanceColors.accentPink,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMiniIndicator(IconData icon, String label, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: FinanceColors.textSecondary,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  // 3. Atalhos Rápidos
  Widget _buildQuickActions() {
    final actions = [
      {'icon': Icons.swap_horiz, 'label': 'Pix'},
      {'icon': Icons.qr_code_scanner, 'label': 'Pagar'},
      {'icon': Icons.send, 'label': 'Transferir'},
      {'icon': Icons.article_outlined, 'label': 'Extrato'},
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: actions.map((action) {
        return Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: FinanceColors.surface,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Icon(
                action['icon'] as IconData,
                color: FinanceColors.textPrimary,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              action['label'] as String,
              style: const TextStyle(
                color: FinanceColors.textSecondary,
                fontSize: 12,
              ),
            ),
          ],
        );
      }).toList(),
    );
  }

  // 4. Gráfico de Evolução (fl_chart)
  Widget _buildChartSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Gastos da Semana",
          style: TextStyle(
            color: FinanceColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 150,
          child: BarChart(
            BarChartData(
              gridData: FlGridData(show: false),
              titlesData: FlTitlesData(show: false),
              borderData: FlBorderData(show: false),
              barGroups: _generateBarGroups(),
            ),
          ),
        ),
      ],
    );
  }

  List<BarChartGroupData> _generateBarGroups() {
    return List.generate(7, (i) {
      return BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: (i + 1) * 3.0,
            color: i == 5
                ? FinanceColors.accentPink
                : FinanceColors.accentGreen.withOpacity(0.3),
            width: 12,
            borderRadius: BorderRadius.circular(4),
          ),
        ],
      );
    });
  }

  // 5. Lista de Transações Recentes
  Widget _buildTransactionList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Transações Recentes",
          style: TextStyle(
            color: FinanceColors.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 15),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: mockTransactions.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final tx = mockTransactions[index];
            return Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: FinanceColors.surface,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: FinanceColors.background,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(tx.icon, color: FinanceColors.textPrimary),
                ),
                title: Text(
                  tx.title,
                  style: const TextStyle(
                    color: FinanceColors.textPrimary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                subtitle: Text(
                  tx.category,
                  style: const TextStyle(
                    color: FinanceColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
                trailing: Text(
                  "${tx.isIncome ? '+' : '-'} R\$ ${tx.value.toStringAsFixed(2)}",
                  style: TextStyle(
                    color: tx.isIncome
                        ? FinanceColors.accentGreen
                        : FinanceColors.accentPink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryChart() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: FinanceColors.surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Gastos por Categoria (%)",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 180,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 100,
                barTouchData: BarTouchData(enabled: true),
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            categoryData[value.toInt()].label,
                            style: const TextStyle(
                              color: Color(0xFF8E94A4),
                              fontSize: 10,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
                barGroups: categoryData.asMap().entries.map((e) {
                  return BarChartGroupData(
                    x: e.key,
                    barRods: [
                      BarChartRodData(
                        toY: e.value.percentage,
                        color: e.value.color,
                        width: 18,
                        borderRadius: BorderRadius.circular(4),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: 100,
                          color: Colors.white10,
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper para formatar o mês/ano no eixo X
  String getMonthYearLabel(double value, int startYear) {
    final date = DateTime(startYear, (value.toInt() % 12) + 1);
    final months = [
      'Jan',
      'Fev',
      'Mar',
      'Abr',
      'Mai',
      'Jun',
      'Jul',
      'Ago',
      'Set',
      'Out',
      'Nov',
      'Dez',
    ];
    // Retorna "Mês Ano" (ex: Jan 2026)
    return "${months[date.month - 1]} ${date.year}";
  }

  Widget _buildComparisonLineChart() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Receitas e Despesas",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 25),
        AspectRatio(
          aspectRatio: 1.7,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.white.withOpacity(0.05),
                  strokeWidth: 1,
                ),
              ),
              titlesData: _buildTitlesData(), // Função auxiliar para os eixos
              borderData: FlBorderData(show: false),
              lineBarsData: [
                // LINHA DE RECEITAS (Verde Água/Teal)
                _lineBarData(
                  spots: const [
                    FlSpot(0, 10000),
                    FlSpot(2, 8500),
                    FlSpot(4, 11000),
                    FlSpot(6, 9500),
                    FlSpot(8, 9000),
                    FlSpot(10, 11500),
                  ],
                  color: FinanceColors.accentGreen,
                ),
                // LINHA DE DESPESAS (Laranja/Coral)
                _lineBarData(
                  spots: const [
                    FlSpot(0, 7500),
                    FlSpot(2, 8000),
                    FlSpot(4, 7800),
                    FlSpot(6, 7600),
                    FlSpot(8, 9800),
                    FlSpot(10, 7500),
                  ],
                  color: FinanceColors.accentPink,
                ),
              ],
              // Efeito de toque para mostrar o ponto exato como na imagem
              lineTouchData: LineTouchData(
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (touchedSpot) => FinanceColors.surface,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // Helper para criar as linhas com o efeito de preenchimento idêntico à foto
  LineChartBarData _lineBarData({
    required List<FlSpot> spots,
    required Color color,
  }) {
    return LineChartBarData(
      spots: spots,
      isCurved: true, // Cria a curva suave (Spline)
      curveSmoothness: 0.35,
      color: color,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
          radius: 4,
          color: FinanceColors.background,
          strokeWidth: 2,
          strokeColor: color,
        ),
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [color.withOpacity(0.2), color.withOpacity(0.0)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  // Configuração dos nomes dos meses e valores R$ no eixo
  FlTitlesData _buildTitlesData() {
    return FlTitlesData(
      rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 60,
          getTitlesWidget: (value, meta) => Text(
            "R\$ ${value.toInt()}",
            style: const TextStyle(
              color: FinanceColors.textSecondary,
              fontSize: 10,
            ),
          ),
        ),
      ),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          getTitlesWidget: (value, meta) {
            const months = ['Jan', 'Mar', 'Mai', 'Jul', 'Set', 'Nov'];
            int index = value.toInt() ~/ 2;
            if (index >= 0 && index < months.length && value % 2 == 0) {
              return Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  months[index],
                  style: const TextStyle(
                    color: FinanceColors.textSecondary,
                    fontSize: 10,
                  ),
                ),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }
}
