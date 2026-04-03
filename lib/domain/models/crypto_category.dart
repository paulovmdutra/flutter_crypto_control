import 'package:flutter_crypto_control/domain/models/entity.dart';

import 'dart:convert';

class CryptoCategory extends Entity<CryptoCategory> {
  final String name;

  CryptoCategory({super.id, required super.publicId, required this.name});

  CryptoCategory copyWith({int? id, String? publicId, String? name}) {
    return CryptoCategory(
      id: id ?? this.id,
      publicId: publicId ?? this.publicId,
      name: name ?? this.name,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{'id': id, 'publicId': publicId, 'name': name};
  }

  factory CryptoCategory.fromMap(Map<String, dynamic> map) {
    return CryptoCategory(
      id: map['id'] != null ? map['id'] as int : 0,
      publicId: map['publicId'] != null ? map['publicId'] as String : '',
      name: map['name'] != null ? map['name'] as String : '',
    );
  }

  @override
  String toJson() => json.encode(toMap());

  factory CryptoCategory.fromJson(String source) =>
      CryptoCategory.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CryptoCategory(name: $name)';
  }

  @override
  bool operator ==(covariant CryptoCategory other) {
    if (identical(this, other)) return true;

    return other.id == id && other.publicId == publicId && other.name == name;
  }

  @override
  int get hashCode {
    return id.hashCode ^ publicId.hashCode ^ name.hashCode;
  }

  @override
  String get entityName => "CryptoCategory";

  @override
  CryptoCategory fromMap(Map<String, dynamic> map) {
    return CryptoCategory.fromMap(map);
  }

  @override
  CryptoCategory fromJson(String source) {
    return CryptoCategory.fromJson(source);
  }
}
