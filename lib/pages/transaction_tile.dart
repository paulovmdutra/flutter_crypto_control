import 'package:flutter/material.dart';

class TransactionTile extends StatefulWidget {
  const TransactionTile({super.key});

  @override
  State<TransactionTile> createState() => _TransactionTileState();
}

class _TransactionTileState extends State<TransactionTile> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF2B3744),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          ListTile(
            leading: _buildLeadingTransaction(),
            title: _buildInfoTransaction(),
            subtitle:
                const Text("5:38 PM", style: TextStyle(color: Colors.white70)),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => setState(() => expanded = !expanded),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF1C2733),
                    shape: const StadiumBorder(),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text("_trade"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          if (expanded)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF22303C),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RowDetail(
                      label: "Fiat value",
                      value: "R\$ 5,75",
                      color: Colors.yellow),
                  RowDetail(
                      label: "Cost basis",
                      value: "R\$ 4,61",
                      color: Colors.white),
                  RowDetail(
                      label: "Gain",
                      value: "R\$ 1,13",
                      color: Color(0xFF00D18B)),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildLeadingTransaction() {
    return Flexible(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(value: false, onChanged: (_) {}),
        ],
      ),
    );
  }

  Widget _buildInfoTransaction() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: _buildCenterInfoTransaction(),
    );
  }

  Widget _buildCenterInfoTransaction() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            color: Colors.deepPurple,
            child:
                const Text("Exchange", style: TextStyle(color: Colors.white))),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildInfoColumn1(),
              _buildIconTrade(),
              _buildInfoColumn2(),
            ],
          ),
        ),
        // Coluna direita (USDC)
      ],
    );
  }

  Widget _buildInfoColumn2() {
    return Column(
      children: [
        Text("Coinbase", style: TextStyle(color: Colors.grey, fontSize: 12)),
        Row(
          children: [
            Text("+ 0,9998 USDC ", style: TextStyle(color: Colors.white)),
            Icon(Icons.attach_money, color: Colors.lightBlueAccent, size: 18),
          ],
        ),
        Row(
          children: [
            Text("≈ R\$ 5,75",
                style: TextStyle(color: Colors.grey, fontSize: 12)),
            Text(" • ", style: TextStyle(color: Colors.grey)),
            Text("R\$ 1,13",
                style: TextStyle(color: Colors.greenAccent, fontSize: 12)),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoColumn1() {
    return Column(
      children: [
        Text("Coinbase", style: TextStyle(color: Colors.grey, fontSize: 12)),
        Row(
          children: [
            Text("- 0,00000986 BTC ", style: TextStyle(color: Colors.white)),
            Icon(Icons.currency_bitcoin, color: Colors.orange, size: 18),
          ],
        ),
        Text("-R\$ 4,61 cost",
            style: TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Padding _buildIconTrade() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Icon(Icons.swap_horiz, color: Colors.blueAccent),
    );
  }
}

class RowDetail extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const RowDetail({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Expanded(
              child:
                  Text(label, style: const TextStyle(color: Colors.white70))),
          Text(value,
              style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
