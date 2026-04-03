import 'dart:convert';
import 'package:flutter_crypto_control/domain/models/entity.dart';

class CreditCard extends Entity<CreditCard> {
  final String name;
  final double limit;
  final double currentBalance;
  final DateTime closingDate;
  final DateTime paymentDate;

  CreditCard({
    required super.id,
    required this.name,
    required this.limit,
    required this.currentBalance,
    required this.closingDate,
    required this.paymentDate,
  });

  CreditCard copyWith({
    int? id,
    String? name,
    double? limit,
    double? currentBalance,
    DateTime? closingDate,
    DateTime? paymentDate,
  }) {
    return CreditCard(
      id: id ?? super.id,
      name: name ?? this.name,
      limit: limit ?? this.limit,
      currentBalance: currentBalance ?? this.currentBalance,
      closingDate: closingDate ?? this.closingDate,
      paymentDate: paymentDate ?? this.paymentDate,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'limit': limit,
      'currentBalance': currentBalance,
      'closingDate': closingDate.millisecondsSinceEpoch,
      'paymentDate': paymentDate.millisecondsSinceEpoch,
    };
  }

  factory CreditCard.fromMap(Map<String, dynamic> map) {
    return CreditCard(
      id: map['id'] as int,
      name: map['name'] as String,
      limit: map['limit'] as double,
      currentBalance: map['currentBalance'] as double,
      closingDate: DateTime.fromMillisecondsSinceEpoch(
        map['closingDate'] as int,
      ),
      paymentDate: DateTime.fromMillisecondsSinceEpoch(
        map['paymentDate'] as int,
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditCard.fromJson(String source) =>
      CreditCard.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CreditCard(id: $id, name: $name, limit: $limit, currentBalance: $currentBalance, closingDate: $closingDate, paymentDate: $paymentDate)';
  }

  @override
  bool operator ==(covariant CreditCard other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.limit == limit &&
        other.currentBalance == currentBalance &&
        other.closingDate == closingDate &&
        other.paymentDate == paymentDate;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        limit.hashCode ^
        currentBalance.hashCode ^
        closingDate.hashCode ^
        paymentDate.hashCode;
  }

  @override
  String get entityName => "CreditCard";

  @override
  CreditCard fromMap(Map<String, dynamic> map) {
    return CreditCard.fromMap(map);
  }
  
  @override
  CreditCard fromJson(String source) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
