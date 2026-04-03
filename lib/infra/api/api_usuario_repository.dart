import 'package:flutter_crypto_control/application/usecase/service_result.dart';
import 'package:flutter_crypto_control/domain/models/user.dart';
import 'package:flutter_crypto_control/infra/api/api_controller_base.dart';
import 'package:flutter_crypto_control/infra/repositories/usuario_repository.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';

class ApiUsuarioRepository extends UsuarioRepository {
  ApiControllerBase controllerBase = ApiControllerBase();

  @override
  Future<CommonResult<User?>> addAsync(User entity) {
    // TODO: implement addAsync
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<User?>> deleteAsync(User entity) {
    // TODO: implement deleteAsync
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<List<User>>> findByCondition(
    bool Function(User p1) predicate,
  ) {
    // TODO: implement findByCondition
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<User?>> firstOrDefaultAsync(
    bool Function(User p1) predicate,
  ) {
    // TODO: implement firstOrDefaultAsync
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<List<User>>> getAllAsync() {
    // TODO: implement getAllAsync
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<List<User>>> getAllPaginateAsync({
    int page = 1,
    int pageSize = 1000,
  }) {
    // TODO: implement getAllPaginateAsync
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<User?>> getByIdAsync(int id) {
    // TODO: implement getByIdAsync
    throw UnimplementedError();
  }

  @override
  Future<ServiceResult<User?>?> login(String login, String senha) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<User?>> updateAsync(User entity) {
    // TODO: implement updateAsync
    throw UnimplementedError();
  }

  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }
}
