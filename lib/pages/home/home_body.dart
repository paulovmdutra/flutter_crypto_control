import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/pages/home/summary_dashboard.dart';
import 'package:flutter_crypto_control/pages/transaction_tile.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';

class HomeBodyScreen extends StatefulWidget {
  const HomeBodyScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeBodyScreenState();
}

class _HomeBodyScreenState extends State<HomeBodyScreen> {
  @override
  Widget build(BuildContext context) {
    return _emptyBody();
  }

  Widget _emptyBody() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CircularButtonWidget(
                      title: "Pagar",
                      icon: Icon(Icons.payment),
                    ),
                    CircularButtonWidget(
                      title: "Receber",
                      icon: Icon(Icons.plus_one),
                    ),
                    CircularButtonWidget(
                      title: "Depositar",
                      icon: Icon(Icons.arrow_downward),
                    ),
                    CircularButtonWidget(
                      title: "Sacar",
                      icon: Icon(Icons.arrow_upward),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            SummaryDashboard(),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Resumo", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            const Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                TransactionTile(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    /*CircularButtonWidget(
                      title: "Pagar",
                      icon: Icon(Icons.payment),
                    ),
                    CircularButtonWidget(
                      title: "Receber",
                      icon: Icon(Icons.plus_one),
                    ),
                    CircularButtonWidget(
                      title: "Depositar",
                      icon: Icon(Icons.arrow_downward),
                    ),
                    CircularButtonWidget(
                      title: "Sacar",
                      icon: Icon(Icons.arrow_upward),
                    ),*/
                  ],
                ),
                const SizedBox(height: 20),
                DashboardCard(title: "Total", value: "120", icon: Icons.home),
                DashboardCard(
                  title: "Com erro",
                  value: "5",
                  icon: Icons.warning,
                ),
                DashboardCard(
                  title: "Residenciais",
                  value: "80",
                  icon: Icons.house,
                ),
                DashboardCard(
                  title: "Comerciais",
                  value: "40",
                  icon: Icons.apartment,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Text(
                "Tipos de Endereço",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            // const SizedBox(height: 200, child: TipoEnderecoChart()),
          ],
        ),
      ),
    );
  }

  List<String> features = ["Restaurantes", "Bebidas", "Mercados", "Farmácias"];

  Widget _buildGridView() {
    return Expanded(
      child: GridView.builder(
        gridDelegate: _createDelegateGrid(),
        itemCount: 4,
        itemBuilder: (context, index) {
          return InkWell(onTap: () {}, child: _createGridTile(features[index]));
        },
      ),
    );
  }

  GridTile _createGridTile(String title) {
    return GridTile(
      header: GridTileBar(
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      child: Card(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(32),
              child: Image.asset("assets/images/placeholder.png"),
            ),
          ],
        ),
      ),
    );
  }

  SliverGridDelegate _createDelegateGrid() {
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 8,
    );
  }
}
/*
class TipoEnderecoChart extends StatelessWidget {
  const TipoEnderecoChart({super.key});

  @override
  Widget build(BuildContext context) {
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: 60,
            color: Colors.blue,
            title: "Residencial",
          ),
          PieChartSectionData(
            value: 40,
            color: Colors.orange,
            title: "Comercial",
          ),
        ],
        sectionsSpace: 2,
        centerSpaceRadius: 60,
      ),
    );
  }
}
*/