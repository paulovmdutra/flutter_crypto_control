import 'package:flutter_crypto_control/application/usecase/service_result.dart';
import 'package:flutter_crypto_control/authenticated.dart';
import 'package:flutter_crypto_control/domain/models/usuario.dart';
import 'package:flutter_crypto_control/infra/repositories/usuario_repository.dart';
import 'package:flutter_crypto_control/service_locator.dart';
import 'package:flutter_crypto_control/shared/utils/encrypt/encryption_context.dart';

class LoginDomainService {
  final UsuarioRepository repository = ServiceLocator.instance
      .get<UsuarioRepository>();
  /*ServiceLocator.instance.getService(ServiceKeys.repositoryUsuario.name)
          as UsuarioRepository;*/
  EncryptionContext context = EncryptionContext();
  Authenticated authenticated = Authenticated();

  // Método para realizar o login
  Future<ServiceResult> save(Usuario user) async {
    final resultApplication = ServiceResult();
    resultApplication.success = false;

    // Verifica se os campos login e senha não estão vazios
    if (user.login!.isEmpty || user.password!.isEmpty) {
      resultApplication.message = "Email e senha são obrigatórios.";
      return resultApplication;
    }
    if (user.id <= 0) {
      // Chama o repositório para autenticar o usuário
      await repository.addAsync(user);
    } else {
      await repository.updateAsync(user);
    }

    // Se o login for bem-sucedido, marca o sucesso e retorna o usuário
    resultApplication.success = true;
    return resultApplication;
  }

  // Método para realizar o login
  Future<ServiceResult> login(String login, String senha) async {
    final resultApplication = ServiceResult();
    resultApplication.success = false;

    // Verifica se os campos login e senha não estão vazios
    if (login.isEmpty || senha.isEmpty) {
      resultApplication.message = "Email e senha são obrigatórios.";
      return resultApplication;
    }

    // Chama o repositório para autenticar o usuário
    final result = await repository.login(login, senha);

    // Verifica se o usuário não foi encontrado ou a senha está incorreta
    if (result == null || result.data == null || result.data!.id == -1) {
      resultApplication.message = "Usuário ou senha inválidos";
      return resultApplication;
    }

    String? token = result.token;
    authenticated.saveToken(token!);

    // Se o login for bem-sucedido, marca o sucesso e retorna o usuário
    resultApplication.success = true;
    return resultApplication;
  }
}
