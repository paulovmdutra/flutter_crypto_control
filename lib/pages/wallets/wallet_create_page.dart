import 'package:flutter/material.dart';
// Adapte os caminhos conforme sua estrutura
import 'package:flutter_crypto_control/controller/wallet_controller.dart';
import 'package:flutter_crypto_control/pages/wallets/wallet_form_widget.dart';
import 'package:flutter_crypto_control/service_locator.dart';

class WalletCreatePage extends StatefulWidget {
  const WalletCreatePage({super.key});

  @override
  State<WalletCreatePage> createState() => _WalletCreatePageState();
}

class _WalletCreatePageState extends State<WalletCreatePage> {
  // 1. Injetar o Controller de Wallet (Ajuste o ServiceKeys.controllerWallet)
  // Assumindo que você tem um WalletController similar ao UsuarioController
  /*final WalletController walletController = ServiceLocator.instance.getService(
    "",
    //ServiceKeys.controllerWallet.name, // Adapte sua ServiceKey para Wallet
  );*/
  final WalletController walletController = ServiceLocator.instance
      .get<WalletController>();

  bool isLoading = false;

  // 2. Método de submissão (Substitua a lógica de pop pela chamada à API)
  void submit() async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      // Implementação real: Chamar a API usando o Controller
      //await walletController.createWallet(walletData);

      // Em caso de sucesso: Navegar de volta ou mostrar sucesso
      if (mounted) {
        Navigator.pop(context, true); // Retorna 'true' para indicar sucesso
      }
    } catch (e) {
      // Tratar o erro (exibir SnackBar ou Diálogo)
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Erro ao cadastrar: $e')));
      }
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text('Cadastrar Nova Carteira')),
        body: WalletFormWidget(
          // O Widget de UI do formulário
          walletController: walletController,
          onSubmit: submit, // Passa o método de submit para o formulário
          isLoading: isLoading, // Passa o estado de loading
        ),
      ),
    );
  }
}
