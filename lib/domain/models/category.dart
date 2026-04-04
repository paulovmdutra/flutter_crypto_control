import 'dart:convert';

import 'package:flutter_crypto_control/domain/models/entity.dart';
import 'package:flutter_crypto_control/domain/models/transaction.dart';

class Category extends Entity<Category> {
  final String name;
  final TransactionType type;
  final int colorValue;
  final bool? archived;
  final double? currentBalance;
  final String iconName;

  Category({
    super.id,
    super.publicId,
    required this.name,
    required this.type,
    required this.colorValue,
    required this.iconName,
    this.currentBalance,
    this.archived = false,
  });

  Category copyWith({
    int? id,
    String? name,
    TransactionType? type,
    int? colorValue,
    bool? archived,
    double? currentBalance,
    String? iconName,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      colorValue: colorValue ?? this.colorValue,
      archived: archived ?? this.archived,
      currentBalance: currentBalance ?? this.currentBalance,
      iconName: iconName ?? this.iconName,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': TransactionType.toCode(type),
      'colorValue': colorValue,
      'archived': archived,
      'currentBalance': currentBalance,
      'iconName': iconName,
    };
  }

  factory Category.createEmpty() {
    return Category(
      id: 0,
      publicId: "",
      name: "Nenhuma categoria cadastrada",
      type: TransactionType.expense,
      colorValue: 0,
      currentBalance: 0.0,
      archived: false,
      iconName: "device_unknown",
    );
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    return Category(
      id: map['id'] != null ? map['id'] as int : 0,
      publicId: map['publicId'] != null ? map['publicId'] as String : "",
      name: map['name'] as String,
      type: map['type'] != null
          ? TransactionType.fromCode(map['type'])
          : TransactionType.unknown,
      colorValue: map['colorValue'] != null ? map['colorValue'] as int : 0,
      archived: map['archived'] != null ? map['archived'] as bool : false,
      currentBalance: map['currentBalance'] != null
          ? (map['currentBalance'] as num).toDouble()
          : 0.0,
      iconName: map['iconName'] != null
          ? map['iconName'] as String
          : "device_unknown",
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(id: $id, name: $name, type: $type, colorValue: $colorValue, archived: $archived, currentBalance: $currentBalance, iconName: $iconName)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.type == type &&
        other.colorValue == colorValue &&
        other.currentBalance == currentBalance &&
        other.iconName == iconName &&
        other.archived == archived;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        colorValue.hashCode ^
        currentBalance.hashCode ^
        iconName.hashCode ^
        archived.hashCode;
  }

  @override
  String get entityName => "Category";

  @override
  Category fromMap(Map<String, dynamic> map) {
    return Category.fromMap(map);
  }

  @override
  Category fromJson(String source) {
    return Category.fromJson(source);
  }
}
