import 'package:flutter_crypto_control/application/usecase/service_result.dart';
import 'package:flutter_crypto_control/domain/models/user.dart';
import 'package:flutter_crypto_control/infra/fake/database_fake.dart';
import 'package:flutter_crypto_control/infra/repositories/usuario_repository.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_crypto_control/shared/utils/encrypt/encryption_context.dart';

class FakeUsuarioRepository extends UsuarioRepository {
  final List<User> _usuarios = usuariosFake;
  int _idCounter = usuariosFake.length;

  @override
  Future<ServiceResult<int>> insert(User entity) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final newEntity = entity.copyWith(id: _idCounter++);

    EncryptionContext encryptionContext = EncryptionContext();

    EncryptedPasswordResult passwordResult = encryptionContext.encryptPassword(
      newEntity.password!,
    );

    newEntity.salt = passwordResult.salt;
    newEntity.password = passwordResult.hash;

    _usuarios.add(newEntity);
    return ServiceResult(success: true, data: newEntity.id);
  }

  Future<ServiceResult<int>> delete(User entity) async {
    await Future.delayed(const Duration(milliseconds: 400));
    _usuarios.removeWhere((u) => u.id == entity.id);
    return ServiceResult(success: true, data: 1);
  }

  Future<ServiceResult<int>> update(User entity) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = _usuarios.indexWhere((u) => u.id == entity.id);
    if (index == -1) {
      return ServiceResult(success: false, message: 'Usuário não encontrado');
    }

    EncryptionContext encryptionContext = EncryptionContext();

    EncryptedPasswordResult passwordResult = encryptionContext.encryptPassword(
      entity.password!,
      salt: entity.salt,
    );

    entity.password = passwordResult.hash;

    _usuarios[index] = entity;
    return ServiceResult(success: true, data: 1);
  }

  Future<ServiceResult<User?>> findById(User entity) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final user = _usuarios.firstWhere(
      (u) => u.id == entity.id,
      orElse: () => User(id: -1),
    );
    if (user.id == -1) {
      return ServiceResult(success: false, message: 'Usuário não encontrado');
    }
    return ServiceResult(success: true, data: user);
  }

  Future<ServiceResult<List<User>>> findAll(User entity) async {
    await Future.delayed(const Duration(milliseconds: 500));
    return ServiceResult(success: true, data: _usuarios);
  }

  @override
  Future<ServiceResult<User?>> login(String login, String senha) async {
    await Future.delayed(const Duration(milliseconds: 500));

    var user = _usuarios.firstWhere(
      (u) => u.login == login,
      orElse: () => User(id: -1),
    );

    if (user.id <= 0) {
      return ServiceResult(success: false, message: 'Usuário não encontrado!');
    }

    EncryptionContext context = EncryptionContext();

    senha = context.encryptPassword(senha, salt: user.salt).hash;

    user = _usuarios.firstWhere(
      (u) => u.login == login && u.password == senha,
      orElse: () => User(id: -1),
    );

    if (user.id <= 0) {
      return ServiceResult(success: false, message: 'Login ou senha inválidos');
    }

    return ServiceResult(success: true, data: user);
  }

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
