import 'dart:convert' as convert;

import 'package:flutter_crypto_control/domain/models/entity.dart';
import 'package:flutter_crypto_control/domain/repositories/repository.dart';
import 'package:flutter_crypto_control/infra/api/api_controller_base.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';

// Defina um Type Factory
typedef FromJsonFactory<T> = T Function(Map<String, dynamic> json);

class ApiRepository<T extends Entity<T>> extends IRepository<T> {
  final FromJsonFactory<T> fromJson; // A função fábrica injetada

  late ApiControllerBase controllerBase;
  String endPointBase;
  ApiRepository({required this.endPointBase, required this.fromJson}) {
    controllerBase = ApiControllerBase(endPointBase: endPointBase);
  }

  @override
  Future<CommonResult<T?>> addAsync(T entity) async {
    Object? body = entity.toJson();
    CommonResult<T?> result = await controllerBase.post(
      body: body,
      fromJson: (json) {
        if (json != null) {
          return entity.fromJson(json);
        }
      },
    );
    return result;
  }

  @override
  Future<CommonResult<T?>> deleteAsync(T entity) async {
    CommonResult<T?> result = await controllerBase.delete(
      endPoint: "${controllerBase.endPointBase}/${entity.id}",
      body: entity.toJson(),
      fromJson: (json) {
        return entity.fromJson(json);
      },
    );
    return result;
  }

  @override
  Future<CommonResult<List<T?>>> findByCondition(bool Function(T?) predicate) {
    // TODO: implement findByCondition
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<T?>> firstOrDefaultAsync(bool Function(T?) predicate) {
    // TODO: implement firstOrDefaultAsync
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<List<T?>?>> getAllAsync() async {
    CommonResult<List<T?>?> result = await controllerBase.get(
      fromJson: (json) {
        final dataJson = json as List<dynamic>;
        final List<T?> data =
            dataJson
                ?.map((m) => fromJson(m as Map<String, dynamic>))
                .toList() ??
            [];
        return data;
      },
    );

    return result;
  }

  @override
  Future<CommonResult<List<T>>> getAllPaginateAsync({
    int page = 1,
    int pageSize = 1000,
  }) {
    // TODO: implement getAllPaginateAsync
    throw UnimplementedError();
  }

  @override
  Future<CommonResult<T?>> getByIdAsync(int id) {
    // TODO: implement getByIdAsync
    throw UnimplementedError();
  }

  @override
  Future<void> init() async {
    return;
  }

  @override
  Future<CommonResult<T?>> updateAsync(T entity) async {
    CommonResult<T?> result = await controllerBase.post(
      body: entity.toJson(),
      fromJson: (json) {
        return entity.fromJson(json);
      },
    );
    return result;
  }
}
