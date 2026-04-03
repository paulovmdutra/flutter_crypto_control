import 'package:flutter_crypto_control/domain/models/entity.dart';
import 'package:flutter_crypto_control/domain/repositories/repository.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';

class FakeRepository<T extends Entity<T>> extends IRepository<T> {
  List<T?> fakeData = [];
  int idCounter = 0;

  FakeRepository();

  @override
  Future<CommonResult<T?>> addAsync(T entity) async {
    await Future.delayed(const Duration(milliseconds: 500)); // Simula latência
    idCounter = fakeData.length + 1;
    entity.id = idCounter;
    fakeData.add(entity);
    return CommonResult.success(data: entity);
  }

  @override
  Future<CommonResult<T?>> deleteAsync(T entity) async {
    await Future.delayed(const Duration(milliseconds: 500));
    var data = fakeData.firstWhere(
      (u) => u!.id == entity.id,
      orElse: () => null,
    );
    if (data == null) return CommonResult.fail(error: CommonError.notFound());
    return CommonResult.success(data: entity);
  }

  @override
  Future<CommonResult<T?>> updateAsync(T entity) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final index = fakeData.indexWhere((u) => u!.id == entity.id);
    if (index == -1) {
      return CommonResult.fail(error: CommonError.notFound());
    }
    fakeData[index] = entity;
    return CommonResult.success(data: entity);
  }

  @override
  Future<CommonResult<T?>> getByIdAsync(int id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final result = fakeData.where((u) => u!.id == id).toList();
    if (result.isEmpty) {
      return CommonResult<T?>.fail(error: CommonError.notFound());
    }
    return CommonResult<T?>.success(data: result.first);
  }

  @override
  Future<CommonResult<List<T?>>> getAllAsync() async {
    await Future.delayed(const Duration(milliseconds: 100));
    return CommonResult.success(data: List<T?>.from(fakeData));
  }

  @override
  Future<CommonResult<List<T?>>> findByCondition(
    bool Function(T? p1) predicate,
  ) async {
    final result = fakeData.where(predicate).toList();
    return CommonResult.success(data: result);
  }

  @override
  Future<CommonResult<T?>> firstOrDefaultAsync(
    bool Function(T? p1) predicate,
  ) async {
    var resultData = fakeData.where(predicate);
    T? result;
    if (resultData.isNotEmpty) result = resultData.first;
    return CommonResult.success(data: result);
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
  Future<void> init() {
    // TODO: implement init
    throw UnimplementedError();
  }
}
