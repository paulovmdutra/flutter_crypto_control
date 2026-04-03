import 'package:flutter_crypto_control/application/usecase/service_result.dart';
import 'package:flutter_crypto_control/domain/models/usuario.dart';
import 'package:flutter_crypto_control/domain/repositories/repository.dart';

abstract class UsuarioRepository implements IRepository<Usuario> {
  Future<ServiceResult<Usuario?>?> login(String login, String senha);
}
