import 'package:flutter_crypto_control/application/usecase/service_result.dart';
import 'package:flutter_crypto_control/controller/controller.dart';
import 'package:flutter_crypto_control/domain/models/user.dart';
import 'package:flutter_crypto_control/domain/domain_services/services.dart';
import 'package:flutter_crypto_control/view_model/login_view_model.dart';
import 'package:flutter_crypto_control/view_model/usuario_view_model.dart';
import 'package:flutter_crypto_control/shared/utils/utils.dart' as util;

class UserController extends Controller<User> {
  LoginViewModel loginViewModel = LoginViewModel();
  UsuarioViewModel usuarioViewModel = UsuarioViewModel();
  final LoginDomainService _loginService = LoginDomainService();

  User? usuario;

  @override
  Future<void> initialize() async {
    loginViewModel.reset();
  }

  @override
  Future<ServiceResult> save() async {
    final user = usuarioViewModel.toEntity();
    return await _loginService.save(user);
  }

  Future<ServiceResult> signIn() async {
    User user = usuarioViewModel.toEntity();
    user.id = -1;
    final resultApplication = await _loginService.save(user);
    return resultApplication;
  }

  // Método para realizar o login
  Future<ServiceResult> login() async {
    final resultApplication = await _loginService.login(
      loginViewModel.loginController.text,
      loginViewModel.passwordController.text,
    );

    return resultApplication;
  }

  String? fieldValidator(String? value) {
    if (util.isEmpty(value)) {
      return 'Campo obrigatório.';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    String pass = usuarioViewModel.passwordController.text;
    String confirmPass = usuarioViewModel.confirmPasswordController.text;
    if (pass != confirmPass) {
      return "Senhas devem ser iguais!";
    }
    return fieldValidator(value);
  }

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório.';
    if (!util.emailRegexValidator(value)) return 'Email inválido!';
    return null;
  }

  String? loginValidator(String? value) {
    if (value == null || value.isEmpty) return 'Campo obrigatório.';
    if (!util.isValidLogin(value)) return 'Nome de usuário inválido!';
    return null;
  }

  bool validate() {
    return validLogin() && validPassword();
  }

  bool validLogin() {
    final text = loginViewModel.loginController.text;
    return text.isNotEmpty;
  }

  bool validPassword() {
    final text = loginViewModel.passwordController.text;
    return text.isNotEmpty;
  }

  @override
  Future<void> reset() async {
    loginViewModel.reset();
  }

  @override
  Future<ServiceResult> delete() async {
    final entity = usuarioViewModel.toEntity();
    /*if (entity.id >= 0) {
      return await _loginService.repository.deleteAsync(entity);
    }*/
    return ServiceResult();
  }

  @override
  Future<ServiceResult> findAll() async {
    return ServiceResult(); //await _loginService.repository.getAllAsync(Usuario());
  }

  @override
  void fromEntity(User entity) {
    usuario = entity;
    return usuarioViewModel.fromEntity(entity);
  }

  @override
  String get title {
    return usuario == null ? 'Novo Usuário' : 'Editar Usuário';
  }
}
