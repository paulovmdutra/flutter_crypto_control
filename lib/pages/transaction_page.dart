// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/pages/transaction_tile.dart';

class TransactionsPage extends StatelessWidget {
  //  List<Transaction> listTransactions = [];

  //TransactionsPage({super.key, required this.listTransactions});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(title: Text('Histórico de Transações')),
      body: ListView(
        children: const [
          TransactionTile(),
          TransactionTile(),
          /*ListTile(
            leading: Icon(Icons.call_received, color: Colors.red),
            title: Text('Compra Bitcoin'),
            subtitle: Text('01/05/2025'),
            trailing: Text('-US\$ 200'),
          ),
          ListTile(
            leading: Icon(Icons.call_made, color: Colors.green),
            title: Text('Venda Solana'),
            subtitle: Text('30/04/2025'),
            trailing: Text('+US\$ 150'),
          ),*/
        ],
      ),
    );
  }
}
