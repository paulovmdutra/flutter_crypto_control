// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:flutter/material.dart';

class LoginViewModel {
  
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginViewModel();

  bool validate() {
    if (loginController.text.isEmpty || passwordController.text.isEmpty) {
      return false;
    }
    return true;
  }

  void reset() {
    loginController.text = "usuario1";
    passwordController.text = "usuario1";
    //loginController.clear();
    //passwordController.clear();
  }

  bool validLogin() {
    return loginController.text.isNotEmpty;
  }

  bool validPassword() {
    return passwordController.text.isNotEmpty;
  }

  LoginViewModel copyWith({
    String? login,
    String? password,
  }) {
    final newModel = LoginViewModel();
    newModel.loginController.text = login ?? loginController.text;
    newModel.passwordController.text = password ?? passwordController.text;
    return newModel;
  }

  Map<String, dynamic> toMap() {
    return {
      'login': loginController.text,
      'password': passwordController.text,
    };
  }

  factory LoginViewModel.fromMap(Map<String, dynamic> map) {
    final model = LoginViewModel();
    model.loginController.text = map['login'] ?? '';
    model.passwordController.text = map['password'] ?? '';
    return model;
  }

  String toJson() => json.encode(toMap());

  factory LoginViewModel.fromJson(String source) =>
      LoginViewModel.fromMap(json.decode(source));

  void dispose() {
    loginController.dispose();
    passwordController.dispose();
  }

  @override
  String toString() =>
      'LoginViewModel(login: ${loginController.text}, password: ${passwordController.text})';

  @override
  bool operator ==(covariant LoginViewModel other) {
    return loginController.text == other.loginController.text &&
        passwordController.text == other.passwordController.text;
  }

  @override
  int get hashCode =>
      loginController.text.hashCode ^ passwordController.text.hashCode;
}
