import 'package:flutter_crypto_control/domain/domain_services/interfaces/icrud_usecase.dart';
import 'package:flutter_crypto_control/domain/models/entity.dart';
import 'package:flutter_crypto_control/domain/repositories/repository.dart';
import 'package:flutter_crypto_control/core/exceptions.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';

class UsecaseBase<T extends Entity<T>> implements ICrudUsecase<T> {
  final IRepository<T> _repository;

  UsecaseBase(this._repository);

  Future<CommonResult<E>> execute<E>(
    Future<CommonResult<E>> Function()? action,
  ) async {
    try {
      return await action!();
    } on FormatException catch (e) {
      throw ServiceException(
        exception: e,
        message: "Erro de formatação durante a operação",
      );
    } on Exception catch (e) {
      throw ServiceException(
        exception: e,
        message: "Ocorreu um erro durante a operação",
      );
    }
  }

  @override
  Future<CommonResult<T?>> add(T entity) async {
    return await execute<T?>(() async {
      var data = await _repository.addAsync(entity);
      return data;
    });
  }

  @override
  Future<CommonResult<T?>> delete(T id) async {
    return await execute<T?>(() async {
      var data = await _repository.deleteAsync(id);
      return data;
    });
  }

  @override
  Future<CommonResult<List<T?>?>> getAll() async {
    return await execute<List<T?>?>(() async {
      var data = await _repository.getAllAsync();
      return data;
    });
  }

  @override
  Future<CommonResult<T?>> update(T entity) async {
    return await execute<T?>(() async {
      var data = await _repository.updateAsync(entity);
      return data;
    });
  }
}
