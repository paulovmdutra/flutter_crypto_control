import 'package:flutter_crypto_control/shared/app_response_models.dart';

abstract class ICrudUsecase<T> {
  Future<CommonResult<List<T?>?>> getAll();
  Future<CommonResult<T?>> add(T entity);
  Future<CommonResult<T?>> update(T entity);
  Future<CommonResult<T?>> delete(T entity);
}
