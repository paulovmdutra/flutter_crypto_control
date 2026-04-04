import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/domain/models/entity.dart';

class SubCategory extends Entity<SubCategory> {
  final String name;
  final int colorValue;
  final String iconName;
  final int categoryId;
  final double? currentBalance;
  final bool? archived;
  final Category? category;

  SubCategory({
    super.id,
    super.publicId,
    required this.name,
    required this.categoryId,
    required this.colorValue,
    required this.iconName,
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
      iconName: iconName,
      currentBalance: currentBalance ?? this.currentBalance,
      archived: archived ?? this.archived,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'categoryId': categoryId,
      'colorValue': colorValue,
      'iconName': iconName,
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
      archived: map['archived'] != null ? map['archived'] as bool : false,
      iconName: map['iconName'] != null ? map['iconName'] as String : "",
      category: map["category"] != null
          ? Category.fromJson(map["category"])
          : Category.createEmpty(),
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory SubCategory.fromJson(String source) =>
      SubCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'SubCategory(id: $id, name: $name, categoryId: $categoryId, colorValue: $colorValue, iconName: $iconName, currentBalance: $currentBalance, archived: $archived, category: $category)';
  }

  @override
  bool operator ==(covariant SubCategory other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.categoryId == categoryId &&
        other.currentBalance == currentBalance &&
        other.colorValue == colorValue &&
        other.iconName == iconName &&
        other.archived == archived;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        categoryId.hashCode ^
        currentBalance.hashCode ^
        colorValue.hashCode ^
        iconName.hashCode ^
        archived.hashCode;
  }

  @override
  String get entityName => "SubCategory";

  @override
  SubCategory fromMap(Map<String, dynamic> map) {
    return SubCategory.fromMap(map);
  }

  @override
  SubCategory fromJson(String source) {
    return SubCategory.fromJson(source);
  }
}
