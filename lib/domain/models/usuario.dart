// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter_crypto_control/domain/models/entity.dart';

class Usuario extends Entity<Usuario> {
  String? nome;
  String? salt;
  String? password;
  String? login;
  String? email;
  DateTime? data;
  String? status;
  String? telefone;
  Usuario({
    super.id,
    this.nome,
    this.salt,
    this.password,
    this.login,
    this.email,
    this.data,
    this.status,
    this.telefone,
  });

  Usuario copyWith({
    int? id,
    String? nome,
    String? salt,
    String? password,
    String? login,
    String? email,
    DateTime? data,
    String? status,
    String? telefone,
  }) {
    return Usuario(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      salt: salt ?? this.salt,
      password: password ?? this.password,
      login: login ?? this.login,
      email: email ?? this.email,
      data: data ?? this.data,
      status: status ?? this.status,
      telefone: telefone ?? this.telefone,
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'nome': nome,
      'salt': salt,
      'password': password,
      'login': login,
      'email': email,
      'data': data?.millisecondsSinceEpoch,
      'status': status,
      'telefone': telefone,
    };
  }

  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'] != null ? map['id'] as int : 0,
      nome: map['nome'] != null ? map['nome'] as String : null,
      salt: map['salt'] != null ? map['salt'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      login: map['login'] != null ? map['login'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      data: map['data'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['data'] as int)
          : null,
      status: map['status'] != null ? map['status'] as String : null,
      telefone: map['telefone'] != null ? map['telefone'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Usuario.fromJson(String source) =>
      Usuario.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Usuario(id: $id, nome: $nome, salt: $salt, password: $password, login: $login, email: $email, data: $data, status: $status, telefone: $telefone)';
  }

  @override
  bool operator ==(covariant Usuario other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.nome == nome &&
        other.salt == salt &&
        other.password == password &&
        other.login == login &&
        other.email == email &&
        other.data == data &&
        other.status == status &&
        other.telefone == telefone;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        nome.hashCode ^
        salt.hashCode ^
        password.hashCode ^
        login.hashCode ^
        email.hashCode ^
        data.hashCode ^
        status.hashCode ^
        telefone.hashCode;
  }

  @override
  String get entityName => "usuario";

  @override
  Usuario fromMap(Map<String, dynamic> map) => Usuario.fromMap(map);
  
  @override
  Usuario fromJson(String source) {
    // TODO: implement fromJson
    throw UnimplementedError();
  }
}
