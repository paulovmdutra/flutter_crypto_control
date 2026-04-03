import 'package:flutter_crypto_control/domain/domain_services/interfaces/icrud_usecase.dart';
import 'package:flutter_crypto_control/domain/models/sub_category.dart';
import 'package:flutter_crypto_control/core/exceptions.dart';
import 'package:flutter_crypto_control/pages/providers/subcategory_providers.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubCategoryController
    extends AsyncNotifier<CommonResult<List<SubCategory?>?>> {
  late final ICrudUsecase<SubCategory> _usecase;

  SubCategoryController();

  // Carrega categorias ao iniciar
  Future<void> loadCategories() async {
    state = const AsyncLoading();
    try {
      final result = await _usecase.getAll();
      state = AsyncData(result);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> addSubCategory(SubCategory newSubCategory) async {
    try {
      state = const AsyncLoading();

      final result = await _usecase.add(newSubCategory);

      if (result.success) {
        final current = state.value?.data ?? [];

        final updatedList = List<SubCategory?>.from(current)..add(result.data!);

        final resultList = CommonResult<List<SubCategory?>>.success(
          data: updatedList,
        );
        state = AsyncData(resultList);

        return;
      }
      state = AsyncError(result, StackTrace.current);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> deleteSubCategory(SubCategory category) async {
    try {
      state = const AsyncLoading();

      final result = await _usecase.delete(category);

      if (result.success) {
        final current = state.value?.data ?? [];
        final updatedList = List<SubCategory?>.from(current)
          ..removeWhere((c) => c?.id == result.data?.id);

        final resultList = CommonResult<List<SubCategory?>>.success(
          data: updatedList,
        );

        state = AsyncData(resultList);
      } else {
        state = AsyncError(result.error!, StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateSubCategory(SubCategory updatedSubCategory) async {
    state = const AsyncLoading();
    try {
      final result = await _usecase.update(updatedSubCategory);

      if (result.success) {
        final current = state.value?.data ?? [];

        final updatedList = current
            .map((c) => c?.id == updatedSubCategory.id ? updatedSubCategory : c)
            .toList();

        final updatedResult = CommonResult<List<SubCategory?>>(
          data: updatedList,
        );

        state = AsyncData(updatedResult);
      } else {
        state = AsyncError(result.error!, StackTrace.current);
      }
    } on Exception catch (e, st) {
      state = AsyncError(e, st);
      throw ServiceException(exception: e, message: e.toString());
    }
  }

  // Métodos de leitura de estado ainda podem existir aqui, se necessário
  SubCategory? getSubCategoryById(int id) {
    try {
      return state.value!.data!.firstWhere((c) => c!.id == id);
    } catch (_) {
      return null;
    }
  }

  String getSubCategoryName(int id) =>
      getSubCategoryById(id)?.name ?? 'Desconhecida';

  @override
  Future<CommonResult<List<SubCategory?>?>> build() async {
    final usecaseAsync = await ref.watch(subCategoryUsecaseProvider.future);
    _usecase = usecaseAsync;
    final result = await _usecase.getAll();
    return result;
  }
}
