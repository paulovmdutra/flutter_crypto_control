import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/account.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/domain/models/payment_method.dart';
import 'package:flutter_crypto_control/domain/models/transaction.dart';
import 'package:flutter_crypto_control/infra/fake/fake_repository.dart';

class InMemoryTransactionRepository extends FakeRepository<Transaction> {
  InMemoryTransactionRepository() {
    final pix = PaymentMethod(id: 1, name: 'PIX', symbol: 'PIX');
    final cash = PaymentMethod(id: 2, name: 'Dinheiro', symbol: 'BRL');
    final creditCard = PaymentMethod(
      id: 3,
      name: 'Cartão de Crédito',
      symbol: 'CDT',
    );
    final boleto = PaymentMethod(id: 4, name: 'Boleto', symbol: 'BOL');
    final cheque = PaymentMethod(id: 5, name: 'Cheque', symbol: 'CHQ');

    // Mocks de Contas e Categorias necessários para popular as transações
    // Em uma aplicação real, esses dados viriam de outros repositórios (AccountRepository, CategoryRepository).
    final Account _mockAcc1 = Account(
      id: 1,
      publicId: '1',
      name: 'Conta Corrente Principal',
      currentBalance: 8500.00,
      currency: "BRL",
    );
    final Account _mockAcc2 = Account(
      id: 2,
      publicId: '2',
      name: 'Carteira/Dinheiro',
      currentBalance: 150.75,
      currency: "BRL",
    );
    final Category _mockCatSalary = Category(
      id: 1,
      publicId: '1',
      name: 'Salário',
      type: TransactionType.income,
      colorValue: 0xFF4CAF50,
      iconCodePoint: Icons.work,
      iconName: "work",
    );
    final Category _mockCatFood = Category(
      id: 2,
      publicId: '2',
      name: 'Alimentação',
      type: TransactionType.expense,
      colorValue: 0xFFFF9800,
      iconCodePoint: Icons.restaurant,
      iconName: "restaurant",
    );
    final Category _mockCatHousing = Category(
      id: 3,
      publicId: '3',
      name: 'Moradia',
      type: TransactionType.expense,
      colorValue: 0xFFF44336,
      iconCodePoint: Icons.home,
      iconName: "home",
    );

    // Mock inicial — transações de exemplo
    final now = DateTime.now();

    fakeData.addAll([
      Transaction(
        id: 1,
        accountId: 1,
        description: 'Salário Mensal',
        amount: 8500.00,
        date: now.subtract(const Duration(days: 2)),
        type: TransactionType.income,
        account: _mockAcc1,
        category: _mockCatSalary,
        categoryId: 1,
        paymentMethod: pix,
      ),
      Transaction(
        id: 2,
        accountId: 2,
        description: 'Compra Supermercado',
        amount: 420.55,
        date: now.subtract(const Duration(days: 1)),
        type: TransactionType.expense,
        account: _mockAcc1,
        category: _mockCatFood,
        categoryId: 2,
        paymentMethod: pix,
      ),
      Transaction(
        id: 3,
        accountId: 1,
        description: 'Assinatura Netflix',
        amount: 55.90,
        date: now.subtract(const Duration(days: 7)),
        type: TransactionType.expense,
        categoryId: 3,
        account: _mockAcc1,
        category: _mockCatHousing,
        paymentMethod: creditCard,
      ),
      Transaction(
        id: 4,
        accountId: 3,
        description: 'Rendimento Cripto (BTC)',
        amount: 312.75,
        date: now.subtract(const Duration(days: 3)),
        type: TransactionType.income,
        categoryId: 1,
        account: _mockAcc2,
        category: _mockCatSalary,
        paymentMethod: pix,
      ),
      Transaction(
        id: 5,
        accountId: 2,
        description: 'Combustível',
        amount: 290.00,
        date: now.subtract(const Duration(days: 4)),
        type: TransactionType.expense,
        categoryId: 2,
        account: _mockAcc2,
        category: _mockCatFood,
        paymentMethod: pix,
      ),
    ]);
  }
}
