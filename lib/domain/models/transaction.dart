// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_crypto_control/domain/models/account.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/domain/models/entity.dart';
import 'package:flutter_crypto_control/domain/models/payment_method.dart';

enum TransactionType {
  income, // entrada
  expense, // saída
  transfer,
  unknown; // transferência entre contas

  // Método auxiliar para buscar o Enum pelo código numérico
  static TransactionType fromCode(int code) {
    switch (code) {
      case 1:
        return TransactionType.expense;
      case 2:
        return TransactionType.income;
      case 3:
        return TransactionType.transfer;
      default:
        return TransactionType.unknown;
    }
  }

  static int toCode(TransactionType type) {
    switch (type) {
      case TransactionType.expense:
        return 1;
      case TransactionType.income:
        return 2;
      case TransactionType.transfer:
        return 3;
      default:
        return 0;
    }
  }
}

class Transaction extends Entity<Transaction> {
  final int accountId;
  final String description;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final int categoryId;
  final String? relatedAccountId; // usado em transferências
  final String? notes;
  final int? paymentMethodId;
  String? documentUrl = 'https://meusistema.com/docs/invoice_123.pdf';

  // Relacionamento: A Transação TEM uma Conta e TEM uma Categoria.
  final Account? account;
  final Category? category;
  final PaymentMethod? paymentMethod;
  Transaction({
    required super.id,
    required this.accountId,
    required this.description,
    required this.amount,
    required this.date,
    required this.type,
    required this.categoryId,
    this.relatedAccountId,
    this.notes,
    this.paymentMethodId,
    this.account,
    this.category,
    this.paymentMethod,
  });

  Transaction copyWith({
    int? id,
    int? accountId,
    String? description,
    double? amount,
    DateTime? date,
    TransactionType? type,
    int? categoryId,
    String? relatedAccountId,
    String? notes,
    int? paymentMethodId,
    Account? account,
    Category? category,
    PaymentMethod? paymentMethod,
  }) {
    return Transaction(
      id: id ?? super.id,
      accountId: accountId ?? this.accountId,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      date: date ?? this.date,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      relatedAccountId: relatedAccountId ?? this.relatedAccountId,
      notes: notes ?? this.notes,
      paymentMethodId: paymentMethodId ?? this.paymentMethodId,
      account: account ?? this.account,
      category: category ?? this.category,
      paymentMethod: paymentMethod ?? this.paymentMethod,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'accountId': accountId,
      'description': description,
      'amount': amount,
      'date': date.millisecondsSinceEpoch,
      'type': type,
      'categoryId': categoryId,
      'relatedAccountId': relatedAccountId,
      'notes': notes,
      'paymentMethodId': paymentMethodId,
      'account': account?.toMap(),
      'category': category?.toMap(),
      'paymentMethod': paymentMethod?.toMap(),
    };
  }

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'] as int,
      accountId: map['accountId'] as int,
      description: map['description'] as String,
      amount: map['amount'] as double,
      date: DateTime.fromMillisecondsSinceEpoch(map['date'] as int),
      type: map['type'] as TransactionType,
      categoryId: map['categoryId'] as int,
      relatedAccountId: map['relatedAccountId'] != null
          ? map['relatedAccountId'] as String
          : null,
      notes: map['notes'] != null ? map['notes'] as String : null,
      paymentMethodId: map['paymentMethodId'] != null
          ? map['paymentMethodId'] as int
          : null,
      account: map['account'] != null
          ? Account.fromMap(map['account'] as Map<String, dynamic>)
          : null,
      category: map['category'] != null
          ? Category.fromMap(map['category'] as Map<String, dynamic>)
          : null,
      paymentMethod: map['paymentMethod'] != null
          ? PaymentMethod.fromMap(map['paymentMethod'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Transaction.fromJson(String source) =>
      Transaction.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Transaction(accountId: $accountId, description: $description, amount: $amount, date: $date, type: $type, categoryId: $categoryId, relatedAccountId: $relatedAccountId, notes: $notes, paymentMethodId: $paymentMethodId, account: $account, category: $category, paymentMethod: $paymentMethod)';
  }

  @override
  bool operator ==(covariant Transaction other) {
    if (identical(this, other)) return true;

    return other.accountId == accountId &&
        other.description == description &&
        other.amount == amount &&
        other.date == date &&
        other.type == type &&
        other.categoryId == categoryId &&
        other.relatedAccountId == relatedAccountId &&
        other.notes == notes &&
        other.paymentMethodId == paymentMethodId &&
        other.account == account &&
        other.category == category &&
        other.paymentMethod == paymentMethod;
  }

  @override
  int get hashCode {
    return accountId.hashCode ^
        description.hashCode ^
        amount.hashCode ^
        date.hashCode ^
        type.hashCode ^
        categoryId.hashCode ^
        relatedAccountId.hashCode ^
        notes.hashCode ^
        paymentMethodId.hashCode ^
        account.hashCode ^
        category.hashCode ^
        paymentMethod.hashCode;
  }

  @override
  // TODO: implement entityName
  String get entityName => throw UnimplementedError();

  @override
  Transaction fromMap(Map<String, dynamic> map) {
    // TODO: implement fromMap
    throw UnimplementedError();
  }

  @override
  Transaction fromJson(String source) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
