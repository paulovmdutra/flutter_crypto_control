import 'package:flutter_crypto_control/application/usecase/service_result.dart';
import 'package:flutter_crypto_control/domain/models/usuario.dart';
import 'package:flutter_crypto_control/infra/api/api_controller_base.dart';
import 'package:flutter_crypto_control/infra/repositories/usuario_repository.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';

class ApiUsuarioRepository extends UsuarioRepository {
  
  ApiControllerBase controllerBase = ApiControllerBase();

  @override
  Future<CommonResult<Usuario?>> addAsync(Usuario entity) {
    // TODO: implement addAsync
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<Usuario?>> deleteAsync(Usuario entity) {
    // TODO: implement deleteAsync
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<List<Usuario>>> findByCondition(
    bool Function(Usuario p1) predicate,
  ) {
    // TODO: implement findByCondition
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<Usuario?>> firstOrDefaultAsync(
    bool Function(Usuario p1) predicate,
  ) {
    // TODO: implement firstOrDefaultAsync
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<List<Usuario>>> getAllAsync() {
    // TODO: implement getAllAsync
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<List<Usuario>>> getAllPaginateAsync({
    int page = 1,
    int pageSize = 1000,
  }) {
    // TODO: implement getAllPaginateAsync
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<Usuario?>> getByIdAsync(int id) {
    // TODO: implement getByIdAsync
    throw UnimplementedError();
  }

  @override
  Future<ServiceResult<Usuario?>?> login(String login, String senha) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<Usuario?>> updateAsync(Usuario entity) {
    // TODO: implement updateAsync
    throw UnimplementedError();
  }
  
  @override
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }
}
