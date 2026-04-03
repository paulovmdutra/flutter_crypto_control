import 'package:flutter_crypto_control/domain/models/asset.dart';
import 'package:flutter_crypto_control/domain/models/entity.dart';
import 'package:flutter_crypto_control/domain/models/transaction.dart';

import 'dart:convert';

class Wallet extends Entity<Wallet> {
  final String name;
  final int assetId;
  final Asset? asset;
  final String currency;
  final double balance;
  final AccountCategory type;
  final String apiKey;
  final String secret_key;
  final String walletAddress;
  final List<Transaction> transactions;

  Wallet({
    super.id,
    required super.publicId,
    required this.name,
    required this.assetId,
    this.asset,
    this.currency = '',
    this.balance = 0.0,
    this.type = AccountCategory.checkingAccount,
    this.apiKey = '',
    this.secret_key = '',
    this.walletAddress = '',
    this.transactions = const [],
  });

  Wallet copyWith({
    int? id,
    String? publicId,
    String? name,
    int? assetId,
    Asset? asset,
    String? currency,
    double? balance,
    AccountCategory? type,
    String? apiKey,
    String? secretKey,
    String? walletAddress,
    List<Transaction>? transactions,
  }) {
    return Wallet(
      id: id ?? this.id,
      publicId: publicId ?? this.publicId,
      name: name ?? this.name,
      assetId: assetId ?? this.assetId,
      asset: asset ?? this.asset,
      currency: currency ?? this.currency,
      balance: balance ?? this.balance,
      type: type ?? this.type,
      apiKey: apiKey ?? this.apiKey,
      secret_key: secretKey ?? this.secret_key,
      walletAddress: walletAddress ?? this.walletAddress,
      transactions: transactions ?? this.transactions,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'publicId': publicId,
      'name': name,
      'assetId': assetId,
      'currency': currency,
      'balance': balance,
      'type': type.index, // Salvando o índice da Enum
      'apiKey': apiKey,
      'secretKey': secret_key,
      'walletAddress': walletAddress,
    };
  }

  factory Wallet.fromMap(Map<String, dynamic> map) {
    return Wallet(
      id: map['id'] != null ? map['id'] as int : 0,
      publicId: map['publicId'] != null ? map['publicId'] as String : '',
      name: map['name'] != null ? map['name'] as String : '',
      assetId: map['assetId'] != null ? map['assetId'] as int : 0,
      currency: map['currency'] != null ? map['currency'] as String : '',
      balance: (map['balance'] as num?)?.toDouble() ?? 0.0,
      type: map['type'] != null
          ? AccountCategory.values[map['type'] as int]
          : AccountCategory.checkingAccount,
      apiKey: map['apiKey'] != null ? map['apiKey'] as String : '',
      secret_key: map['secretKey'] != null ? map['secretKey'] as String : '',
      walletAddress: map['walletAddress'] != null
          ? map['walletAddress'] as String
          : '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Wallet.fromJson(String source) =>
      Wallet.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Wallet(name: $name, balance: $balance, currency: $currency)';
  }

  @override
  bool operator ==(covariant Wallet other) {
    if (identical(this, other)) return true;
    return other.id == id &&
        other.publicId == publicId &&
        other.name == name &&
        other.assetId == assetId &&
        other.balance == balance &&
        other.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        publicId.hashCode ^
        name.hashCode ^
        assetId.hashCode ^
        balance.hashCode ^
        type.hashCode;
  }

  @override
  String get entityName => "Wallet";

  @override
  Wallet fromMap(Map<String, dynamic> map) => Wallet.fromMap(map);

  @override
  Wallet fromJson(String source) => Wallet.fromJson(source);
}

// Exemplo da Enum que você possui no C#
enum AccountCategory {
  checkingAccount,
  savings,
  creditCard,
  cash,
  wallet,
  investment,
  exchange,
  brokerageAccount,
  hotWallet,
  coldWallet,
  physicalCash,
}
