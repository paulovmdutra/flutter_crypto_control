import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/domain/models/user.dart';

class UsuarioViewModel {
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController saltController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController statusController = TextEditingController();
  final TextEditingController telefoneController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController dataNascimentoController =
      TextEditingController();

  final ValueNotifier<DateTime?> dataNotifier = ValueNotifier(null);

  int? id = 0;

  UsuarioViewModel({this.id = 0});

  void fromEntity(User usuario) {
    id = usuario.id;
    nomeController.text = usuario.nome ?? '';
    saltController.text = usuario.salt ?? '';
    passwordController.text = usuario.password ?? '';
    confirmPasswordController.text = usuario.password ?? '';
    loginController.text = usuario.login ?? '';
    emailController.text = usuario.email ?? '';
    statusController.text = usuario.status ?? '';
    telefoneController.text = usuario.telefone ?? '';
    dataNotifier.value = usuario.data;
  }

  User toEntity() {
    return User(
      id: id!,
      nome: nomeController.text,
      salt: saltController.text,
      password: passwordController.text,
      login: loginController.text,
      email: emailController.text,
      status: statusController.text,
      telefone: telefoneController.text,
      data: dataNotifier.value,
    );
  }

  void reset() {
    nomeController.clear();
    saltController.clear();
    passwordController.clear();
    loginController.clear();
    emailController.clear();
    statusController.clear();
    telefoneController.clear();
    dataNotifier.value = null;
  }

  void dispose() {
    nomeController.dispose();
    saltController.dispose();
    passwordController.dispose();
    loginController.dispose();
    emailController.dispose();
    statusController.dispose();
    telefoneController.dispose();
    dataNotifier.dispose();
  }

  @override
  String toString() {
    return 'UsuarioViewModel(id: $id, nome: ${nomeController.text}, salt: ${saltController.text}, '
        'password: ${passwordController.text}, login: ${loginController.text}, '
        'email: ${emailController.text}, data: ${dataNotifier.value}, '
        'status: ${statusController.text}, telefone: ${telefoneController.text})';
  }
}
