// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_crypto_control/domain/models/entity.dart';

class PaymentMethod extends Entity<PaymentMethod> {
  final String name;
  final String symbol;
  final String? description;

  PaymentMethod({
    required super.id,
    required this.name,
    required this.symbol,
    this.description,
  });

  PaymentMethod copyWith({
    int? id,
    String? name,
    String? symbol,
    String? description,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      name: name ?? this.name,
      symbol: symbol ?? this.symbol,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'symbol': symbol,
      'description': description,
    };
  }

  factory PaymentMethod.fromMap(Map<String, dynamic> map) {
    return PaymentMethod(
      id: map['id'] as int,
      name: map['name'] as String,
      symbol: map['symbol'] as String,
      description: map['description'] != null
          ? map['description'] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethod.fromJson(String source) =>
      PaymentMethod.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'PaymentMethod(id: $id, name: $name, symbol: $symbol, description: $description)';
  }

  @override
  bool operator ==(covariant PaymentMethod other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.symbol == symbol &&
        other.description == description;
  }

  @override
  int get hashCode {
    return id.hashCode ^ name.hashCode ^ symbol.hashCode ^ description.hashCode;
  }

  @override
  String get entityName => "PaymentMethod";

  @override
  PaymentMethod fromMap(Map<String, dynamic> map) {
    return PaymentMethod.fromMap(map);
  }
  
  @override
  PaymentMethod fromJson(String source) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
