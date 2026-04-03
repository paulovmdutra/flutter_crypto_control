import 'package:flutter/material.dart';

import 'package:flutter/widgets.dart';
 // O model que criamos
/// Model para representar uma Carteira (Wallet) em Flutter.
/// Ideal para serialização e desserialização (JSON).
class WalletModel {
  // O Flutter não tem o tipo Guid nativo. Usamos String para representar
  // o identificador público (UUID/GUID)
  final String publicId;

  // Nome da carteira (equivalente ao 'Name' em C#)
  final String name;

  // Moeda utilizada (BTC, ETH, etc. - equivalente ao 'Currency' em C#)
  final String currency;

  // Saldo atual (usamos 'double' em Dart para valores decimais de ponto flutuante,
  // que geralmente mapeia para 'decimal' em C# no contexto de API)
  final double balance;

  // API Key (opcional)
  final String apiKey;

  // Secret Key (opcional)
  final String secretKey;

  // API Password (opcional)
  final String apiPassword;

  // Construtor obrigatório
  WalletModel({
    required this.publicId,
    required this.name,
    required this.currency,
    required this.balance,
    required this.apiKey,
    required this.secretKey,
    required this.apiPassword,
  });

  // --- MÉTODOS DE SERIALIZAÇÃO ---

  // 1. Factory method para criar um objeto WalletModel a partir de um JSON (Mapa)
  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      // Se a PublicId vier como null, usamos uma string vazia como fallback
      publicId: json['publicId'] as String? ?? '', 
      
      // O campo 'Name' é obrigatório no C#, então é esperado que venha.
      name: json['name'] as String,
      
      currency: json['currency'] as String,
      
      // Converte o número (que pode ser int ou double no JSON) para double
      balance: (json['balance'] as num).toDouble(), 
      
      apiKey: json['apiKey'] as String? ?? '',
      secretKey: json['secretKey'] as String? ?? '',
      apiPassword: json['apiPassword'] as String? ?? '',
    );
  }

  // 2. Método para converter o objeto WalletModel em um JSON (Mapa) para envio à API
  // Este é o formato que você usará no corpo da requisição POST/PUT.
  Map<String, dynamic> toJson() {
    return {
      // Nota: PublicId geralmente não é enviada em um POST de cadastro (CREATE),
      // mas mantida para consistência no modelo.
      'publicId': publicId, 
      'name': name,
      'currency': currency,
      'balance': balance,
      'apiKey': apiKey,
      'secretKey': secretKey,
      'apiPassword': apiPassword,
    };
  }
}
class WalletViewModel {
  // TextEditingControllers para todos os campos do WalletModel (exceto publicId e balance)
  final nameController = TextEditingController();
  final currencyController = TextEditingController();
  final apiKeyController = TextEditingController();
  final secretKeyController = TextEditingController();
  final apiPasswordController = TextEditingController();

  // Usamos um controller separado para o saldo, pois é um double/decimal
  final balanceController = TextEditingController();

  // Converte os dados dos Controllers para o WalletModel
  WalletModel toModel() {
    // Tenta converter o texto do saldo para double; usa 0.0 se falhar
    final balance =
        double.tryParse(balanceController.text.replaceAll(',', '.')) ?? 0.0;

    return WalletModel(
      publicId: '', // Será definido no backend
      name: nameController.text.trim(),
      currency: currencyController.text.trim(),
      balance: balance,
      apiKey: apiKeyController.text.trim(),
      secretKey: secretKeyController.text.trim(),
      apiPassword: apiPasswordController.text.trim(),
    );
  }

  // Limpar os campos após o cadastro, se necessário
  void clear() {
    nameController.clear();
    currencyController.clear();
    apiKeyController.clear();
    secretKeyController.clear();
    apiPasswordController.clear();
    balanceController.clear();
  }

  // Descartar os controllers para evitar vazamento de memória
  void dispose() {
    nameController.dispose();
    currencyController.dispose();
    apiKeyController.dispose();
    secretKeyController.dispose();
    apiPasswordController.dispose();
    balanceController.dispose();
  }
}

class WalletController {
  final WalletViewModel walletViewModel = WalletViewModel();
  final walletService; // Serviço de API

  WalletController({required this.walletService});

  // Método de validação genérico (similar ao seu fieldValidator)
  String? fieldValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  // Método de validação de saldo (opcionalmente)
  String? balanceValidator(String? value) {
    if (value != null && value.isNotEmpty) {
      if (double.tryParse(value.replaceAll(',', '.')) == null) {
        return 'Insira um número válido para o saldo.';
      }
    }
    return null; // Saldo opcional e/ou 0 é válido
  }

  // Lógica principal de salvamento (similar ao seu widget.userController.save())
  Future<({bool success, String message})> save() async {
    final walletModel = walletViewModel.toModel();

    // Simulação: Aqui você chamaria o walletService.create(walletModel)
    try {
      // await walletService.createWallet(walletModel);
      await Future.delayed(const Duration(seconds: 1)); // Simula API call

      // Limpar campos após sucesso (opcional)
      walletViewModel.clear();

      return (success: true, message: "Carteira cadastrada com sucesso!");
    } catch (e) {
      // Retornar erro do serviço de API
      return (success: false, message: "Falha ao cadastrar a carteira: $e");
    }
  }

  // Lembrar de chamar o dispose quando o Controller for descartado pelo ServiceLocator
  void dispose() {
    walletViewModel.dispose();
  }
}
