// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_crypto_control/domain/models/entity.dart';

class Account extends Entity<Account> {
  final String name;
  final double currentBalance;
  final String currency;
  final bool? archived;

  Account({
    super.id,
    required super.publicId,
    required this.name,
    required this.currentBalance,
    required this.currency,
    this.archived = false,
  });

  Account copyWith({
    int? id,
    String? publicId,
    String? name,
    double? currentBalance,
    String? currency,
    bool? archived,
  }) {
    return Account(
      id: id ?? this.id,
      publicId: publicId ?? this.publicId,
      name: name ?? this.name,
      currentBalance: currentBalance ?? this.currentBalance,
      currency: currency ?? this.currency,
      archived: archived ?? this.archived,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'publicId': publicId,
      'name': name,
      'currentBalance': currentBalance,
      'currency': currency,
      'archived': archived,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'] != null ? map['id'] as int : 0,
      publicId: map['publicId'] != null ? map['publicId'] as String : '',
      name: map['name'] != null ? map['name'] as String : '',
      currentBalance: map['currentBalance'] != null
          ? map['currentBalance'] as double
          : 0.0,
      currency: map['currency'] != null ? map['currency'] as String : '',
      archived: map['archived'] != null ? map['archived'] as bool : false,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Account.fromJson(String source) =>
      Account.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Account(name: $name, currentBalance: $currentBalance, currency: $currency, archived: $archived)';
  }

  @override
  bool operator ==(covariant Account other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.publicId == publicId &&
        other.name == name &&
        other.currentBalance == currentBalance &&
        other.currency == currency &&
        other.archived == archived;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        publicId.hashCode ^
        name.hashCode ^
        currentBalance.hashCode ^
        currency.hashCode ^
        archived.hashCode;
  }

  @override
  String get entityName => "Account";

  @override
  Account fromMap(Map<String, dynamic> map) {
    return Account.fromMap(map);
  }

  @override
  Account fromJson(String source) {
    return Account.fromJson(source);
  }
}
