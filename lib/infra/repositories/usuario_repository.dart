import 'package:flutter_crypto_control/application/usecase/service_result.dart';
import 'package:flutter_crypto_control/domain/models/user.dart';
import 'package:flutter_crypto_control/domain/repositories/repository.dart';

abstract class UsuarioRepository implements IRepository<User> {
  Future<ServiceResult<User?>?> login(String login, String senha);
}
