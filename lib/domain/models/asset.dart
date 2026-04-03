import 'dart:convert';

import 'package:flutter_crypto_control/domain/models/crypto_category.dart';
import 'package:flutter_crypto_control/domain/models/entity.dart';
import 'package:flutter_crypto_control/domain/models/wallet.dart';

class Asset extends Entity<Asset> {
  final String name;
  final String symbol;
  final int? cryptoCategoryId;
  // Relacionamento com o objeto
  final CryptoCategory? cryptoCategory;
  final String urlIcon;
  final List<Wallet> wallets;

  Asset({
    super.id,
    required super.publicId,
    required this.name,
    required this.symbol,
    this.cryptoCategoryId,
    this.cryptoCategory,
    this.urlIcon = '',
    List<Wallet>? wallets,
  }) : this.wallets = wallets ?? [];

  Asset copyWith({
    int? id,
    String? publicId,
    String? name,
    String? symbol,
    int? cryptoCategoryId,
    CryptoCategory? cryptoCategory,
    String? urlIcon,
    List<Wallet>? wallets,
  }) {
    return Asset(
      id: id ?? this.id,
      publicId: publicId ?? this.publicId,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      cryptoCategoryId: cryptoCategoryId ?? this.cryptoCategoryId,
      cryptoCategory: cryptoCategory ?? this.cryptoCategory,
      urlIcon: urlIcon ?? this.urlIcon,
      wallets: wallets ?? this.wallets,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'publicId': publicId,
      'name': name,
      'symbol': symbol,
      'cryptoCategoryId': cryptoCategoryId,
      // Converte o objeto relacionado para mapa se ele existir
      'cryptoCategory': cryptoCategory?.toMap(),
      'urlIcon': urlIcon,
    };
  }

  factory Asset.fromMap(Map<String, dynamic> map) {
    return Asset(
      id: map['id'] != null ? map['id'] as int : 0,
      publicId: map['publicId'] != null ? map['publicId'] as String : '',
      name: map['name'] != null ? map['name'] as String : '',
      symbol: map['symbol'] != null ? map['symbol'] as String : '',
      cryptoCategoryId: map['cryptoCategoryId'] as int?,
      // Mapeamento do objeto aninhado
      cryptoCategory: map['cryptoCategory'] != null
          ? CryptoCategory.fromMap(
              map['cryptoCategory'] as Map<String, dynamic>,
            )
          : null,
      urlIcon: map['urlIcon'] != null ? map['urlIcon'] as String : '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Asset.fromJson(String source) =>
      Asset.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Asset(name: $name, symbol: $symbol, category: ${cryptoCategory?.name})';
  }

  @override
  bool operator ==(covariant Asset other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.publicId == publicId &&
        other.name == name &&
        other.symbol == symbol &&
        other.cryptoCategoryId == cryptoCategoryId &&
        other.cryptoCategory == cryptoCategory &&
        other.urlIcon == urlIcon;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        publicId.hashCode ^
        name.hashCode ^
        symbol.hashCode ^
        cryptoCategoryId.hashCode ^
        cryptoCategory.hashCode ^
        urlIcon.hashCode;
  }

  @override
  String get entityName => "Asset";

  @override
  Asset fromMap(Map<String, dynamic> map) => Asset.fromMap(map);

  @override
  Asset fromJson(String source) => Asset.fromJson(source);
}