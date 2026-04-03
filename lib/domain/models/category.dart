// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_crypto_control/domain/models/entity.dart';
import 'package:flutter_crypto_control/domain/models/transaction.dart';

class Category extends Entity<Category> {
  final String name;
  final TransactionType type;
  final int colorValue;
  final IconData iconCodePoint;
  final bool? archived;
  final double? currentBalance;

  Category({
    required super.id,
    super.publicId,
    required this.name,
    required this.type,
    required this.colorValue,
    required this.iconCodePoint,
    this.currentBalance,
    this.archived = false,
  });

  Color get color => Color(colorValue);

  Category copyWith({
    int? id,
    String? name,
    TransactionType? type,
    int? colorValue,
    IconData? iconCodePoint,
    bool? archived,
    double? currentBalance,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      colorValue: colorValue ?? this.colorValue,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      archived: archived ?? this.archived,
      currentBalance: currentBalance ?? this.currentBalance,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'type': TransactionType.toCode(type),
      'colorValue': colorValue,
      'iconCodePoint': iconCodePoint.codePoint,
      'archived': archived,
      'currentBalance': currentBalance,
      'iconFontFamily': iconCodePoint.fontFamily,
    };
  }

  factory Category.createEmpty() {
    return Category(
      id: 0,
      publicId: "",
      name: "Nenhuma categoria cadastrada",
      type: TransactionType.expense,
      colorValue: 0,
      iconCodePoint: Icons.device_unknown,
      currentBalance: 0.0,
      archived: false,
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
      archived: map['archived'] != map['archived']
          ? map['archived'] as bool
          : false,
      iconCodePoint: map['iconCodePoint'] != null
          ? IconData(map['iconCodePoint'] as int, fontFamily: 'MaterialIcons')
          : Icons.device_unknown,
      currentBalance: map['currentBalance'] != null
          ? map['currentBalance'] as double
          : 0.0,
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Category(id: $id, name: $name, type: $type, colorValue: $colorValue, iconCodePoint: $iconCodePoint)';
  }

  @override
  bool operator ==(covariant Category other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.type == type &&
        other.colorValue == colorValue &&
        other.iconCodePoint == iconCodePoint &&
        other.currentBalance == currentBalance &&
        other.archived == archived;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        type.hashCode ^
        colorValue.hashCode ^
        iconCodePoint.hashCode ^
        currentBalance.hashCode ^
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
