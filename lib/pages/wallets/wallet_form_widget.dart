// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_crypto_control/controller/wallet_controller.dart';
import 'package:flutter_crypto_control/pages/app/apps.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';

class WalletFormWidget extends StatefulWidget {
  final WalletController walletController;
  final Function() onSubmit;
  bool isLoading = false;

  WalletFormWidget({
    Key? key,
    required this.walletController,
    required this.isLoading,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<WalletFormWidget> createState() => _WalletFormWidgetState();
}

class _WalletFormWidgetState extends State<WalletFormWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _obscureSecretKeys = true; // Para esconder as API Keys
  bool isLoading = false; // Estado de loading local

  // Métodos de preenchimento fictício (opcional)
  void preencherControllersComDadosFicticios() {
    final viewModel = widget.walletController.walletViewModel;
    viewModel.nameController.text = 'Exchange Principal';
    viewModel.currencyController.text = 'USDT';
    viewModel.balanceController.text = '1500.50';
    viewModel.apiKeyController.text = 'API-KEY-SIMULADA-123';
    viewModel.secretKeyController.text = 'SECRET-KEY-SIMULADA-456';
  }

  @override
  void initState() {
    super.initState();
    preencherControllersComDadosFicticios(); // Para testes
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    if (isLoading) {
      return const Center(child: CircularProgress()); // Seu widget de progresso
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(child: _buildForm(context, screenHeight)),
    );
  }

  AppForm _buildForm(BuildContext context, screenHeight) {
    Widget spacer(double factor) => SizedBox(height: screenHeight * factor);
    final viewModel = widget.walletController.walletViewModel;
    final controller = widget.walletController;

    return AppForm(
      focusNode: FocusScopeNode(),
      formKey: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          spacer(.05),
          const Text(
            'Nova Carteira',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          spacer(.01),
          Text(
            'Dados básicos e de integração com a Exchange.',
            style: TextStyle(fontSize: 16, color: Colors.black.withOpacity(.6)),
          ),
          spacer(.05),

          // --- Nome da Carteira ---
          InputFormField(
            controller: viewModel.nameController,
            labelText: 'Nome da Carteira',
            validator: controller.fieldValidator,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
          ),
          spacer(.025),

          // --- Moeda ---
          InputFormField(
            controller: viewModel.currencyController,
            labelText: 'Moeda Principal (Ex: USDT, BRL)',
            validator: controller.fieldValidator,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
          ),
          spacer(.025),

          // --- Saldo Inicial ---
          InputFormField(
            controller: viewModel.balanceController,
            labelText: 'Saldo Inicial (Opcional)',
            validator: controller.balanceValidator,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
          ),
          spacer(.025),

          const Divider(),
          spacer(.025),

          // --- API Key ---
          InputFormField(
            controller: viewModel.apiKeyController,
            labelText: 'API Key',
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
            // Validação não obrigatória
            // validator: controller.fieldValidator,
          ),
          spacer(.025),

          // --- Secret Key ---
          InputFormField(
            controller: viewModel.secretKeyController,
            labelText: 'Secret Key',
            obscureText: _obscureSecretKeys,
            textInputAction: TextInputAction.next,
            // Validação não obrigatória
            // validator: controller.fieldValidator,
            suffixIcon: IconButton(
              icon: Icon(
                _obscureSecretKeys ? Icons.visibility_off : Icons.visibility,
              ),
              onPressed: () {
                setState(() {
                  _obscureSecretKeys = !_obscureSecretKeys;
                });
              },
            ),
          ),
          spacer(.025),

          // --- API Password (Se aplicável) ---
          InputFormField(
            controller: viewModel.apiPasswordController,
            labelText: 'API Password (Opcional)',
            obscureText: _obscureSecretKeys,
            textInputAction: TextInputAction.done,
            // Validação não obrigatória
            // validator: controller.fieldValidator,
          ),
          spacer(.075),

          // --- Botão de Salvar ---
          FormButton(
            text: 'Salvar Carteira',
            onPressed: () {
              widget.onSubmit;
            },
          ),
          spacer(.05),

          // Botão de Cancelar/Voltar
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'Cancelar e Voltar',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
