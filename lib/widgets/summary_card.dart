import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart'; // Você precisará importar e configurar esta biblioteca

class SummaryCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color iconColor;
  final double percentageChange;
  final List<double> chartData;

  const SummaryCard({
    Key? key,
    required this.title,
    required this.value,
    required this.icon,
    required this.iconColor,
    required this.percentageChange,
    required this.chartData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Para simplificar o gráfico, usaremos um Container no lugar do fl_chart
    // Em produção, você usaria o LineChart da biblioteca fl_chart
    /* Widget lineChartPlaceholder = Container(
      height: 70, // Altura fixa para o gráfico
      alignment: Alignment.bottomLeft,
      child: Image.asset(
        'assets/images/line_chart_mock.png', // Mock de imagem ou use o widget de chart real
        fit: BoxFit.cover,
      ),
    );*/

    Color customColor = iconColor.withAlpha(10);

    // O Widget Container com a decoração simula o estilo do Card da imagem
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            // 1. Ícone e Valor Principal (Linha Superior)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: customColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: iconColor, size: 24),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            // 2. Título (Abaixo do Valor Principal)
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
              child: Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // 3. Placeholder do Gráfico
            // Placeholder do Gráfico SUBSTITUÍDO pelo MiniLineChart
            SizedBox(
              height: 70, // Altura para o gráfico
              child: MiniLineChart(
                dataPoints: chartData,
                chartColor: iconColor, // Use a mesma cor do ícone
              ),
            ),

            // 4. Mudança Percentual (Rodapé)
            Row(
              children: [
                Icon(
                  percentageChange >= 0
                      ? Icons.arrow_upward
                      : Icons.arrow_downward,
                  color: percentageChange >= 0 ? Colors.green : Colors.red,
                  size: 16,
                ),
                const SizedBox(width: 4),
                Text(
                  '${percentageChange.toStringAsFixed(2)}%',
                  style: TextStyle(
                    color: percentageChange >= 0 ? Colors.green : Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MiniLineChart extends StatelessWidget {
  final List<double> dataPoints;
  final Color chartColor;

  const MiniLineChart({
    Key? key,
    required this.dataPoints,
    required this.chartColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mapeia os dados para o formato FlSpot que o fl_chart espera
    List<FlSpot> spots = dataPoints
        .asMap()
        .entries
        .map((entry) => FlSpot(entry.key.toDouble(), entry.value))
        .toList();

    // Define os valores mínimos e máximos para dimensionar o gráfico
    double minY = dataPoints.reduce((a, b) => a < b ? a : b);
    double maxY = dataPoints.reduce((a, b) => a > b ? a : b);

    // Adiciona uma pequena margem para os eixos ficarem melhores
    minY = minY > 0 ? minY * 0.9 : minY * 1.1;
    maxY = maxY * 1.1;

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, right: 8.0),
      child: LineChart(
        LineChartData(
          // 1. Configuração da Grade e Eixos (Removidas para um visual clean)
          gridData: const FlGridData(show: false),
          titlesData: const FlTitlesData(show: false),
          borderData: FlBorderData(show: false), // Remove bordas
          // 2. Configuração dos Dados
          minX: 0,
          maxX: (dataPoints.length - 1).toDouble(),
          minY: minY,
          maxY: maxY,

          lineBarsData: [
            LineChartBarData(
              spots: spots,
              isCurved: true, // Deixa a linha suave
              color: chartColor,
              barWidth: 3,
              isStrokeCapRound: true,
              dotData: FlDotData(
                show: true, // Mostra os pontos
                getDotPainter: (spot, percent, bar, index) {
                  return FlDotCirclePainter(
                    radius: 4,
                    color: chartColor,
                    strokeWidth: 0,
                  );
                },
              ),
              belowBarData: BarAreaData(
                show: true,
                // Cria um gradiente sutil abaixo da linha
                gradient: LinearGradient(
                  colors: [chartColor.withAlpha(10), chartColor.withAlpha(0)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ],
        ),
        // swapAnimationDuration: const Duration(milliseconds: 150), // Animação
        //swapAnimationCurve: Curves.linear,
      ),
    );
  }
}
