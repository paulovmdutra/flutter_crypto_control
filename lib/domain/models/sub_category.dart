import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/domain/models/entity.dart';

class SubCategory extends Entity<SubCategory> {
  final String name;
  final int colorValue;
  final IconData iconCodePoint;
  final int categoryId;
  final double? currentBalance;
  final bool? archived;
  final Category? category;

  SubCategory({
    required super.id,
    super.publicId,
    required this.name,
    required this.categoryId,
    required this.colorValue,
    required this.iconCodePoint,
    this.currentBalance,
    this.category,
    this.archived,
  });

  Color get color => Color(colorValue);
  String? get categoryName {
    if (category != null) {
      return category?.name;
    }
    return '';
  }

  SubCategory copyWith({
    int? id,
    String? name,
    int? categoryId,
    IconData? iconCodePoint,
    int? colorValue,
    double? currentBalance,
    bool? archived,
    Category? category,
  }) {
    return SubCategory(
      id: id ?? super.id,
      categoryId: categoryId ?? this.categoryId,
      category: category ?? this.category,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
      iconCodePoint: iconCodePoint ?? this.iconCodePoint,
      currentBalance: currentBalance ?? this.currentBalance,
      archived: archived ?? this.archived,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'colorValue': colorValue,
      'iconCodePoint': iconCodePoint.codePoint,
      'currentBalance': currentBalance,
      'archived': archived,
    };
  }

  factory SubCategory.fromMap(Map<String, dynamic> map) {
    return SubCategory(
      id: map['id'] != null ? map['id'] as int : 0,
      publicId: map['publicId'] != null ? map['publicId'] as String : "",
      categoryId: map['categoryId'] != null ? map['categoryId'] as int : 0,
      name: map['name'] != null ? map['name'] as String : "",
      colorValue: map['colorValue'] != null ? map['colorValue'] as int : 0,
      currentBalance: map['currentBalance'] != null
          ? map['currentBalance'] as double
          : 0,
      archived: map['archived'] != map['archived']
          ? map['archived'] as bool
          : false,
      iconCodePoint: map['iconCodePoint'] != null
          ? IconData(map['iconCodePoint'] as int, fontFamily: 'MaterialIcons')
          : Icons.device_unknown,
      category: map["category"] != null
          ? Category.fromJson(map["category"])
          : Category.createEmpty(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SubCategory.fromJson(String source) =>
      SubCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubCategory(id: $id, name: $name, categoryId: $categoryId, colorValue: $colorValue, iconCodePoint: $iconCodePoint)';
  }

  @override
  bool operator ==(covariant SubCategory other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.categoryId == categoryId &&
        other.currentBalance == currentBalance &&
        other.colorValue == colorValue &&
        other.iconCodePoint == iconCodePoint;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        categoryId.hashCode ^
        currentBalance.hashCode ^
        colorValue.hashCode ^
        iconCodePoint.hashCode;
  }

  @override
  String get entityName => "SubCategory";

  @override
  SubCategory fromMap(Map<String, dynamic> map) {
    return SubCategory.fromMap(map);
  }

  @override
  SubCategory fromJson(String source) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
