import 'package:flutter_crypto_control/domain/domain_services/interfaces/icrud_usecase.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/pages/providers/category_providers.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CategoryController extends AsyncNotifier<CommonResult<List<Category?>?>> {
  late final ICrudUsecase<Category> _usecase;

  CategoryController();

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

  Future<void> addCategory(Category newCategory) async {
    try {
      state = const AsyncLoading();

      final result = await _usecase.add(newCategory);

      if (result.success) {
        final current = state.value?.data ?? [];

        final updatedList = List<Category?>.from(current)..add(result.data!);

        final resultList = CommonResult<List<Category?>>.success(
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

  Future<void> deleteCategory(Category category) async {
    try {
      state = const AsyncLoading();

      final result = await _usecase.delete(category);

      if (result.success) {
        final current = state.value?.data ?? [];
        final updatedList = List<Category?>.from(current)
          ..removeWhere((c) => c?.id == result.data?.id);

        final resultList = CommonResult<List<Category?>>.success(
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

  Future<void> updateCategory(Category updatedCategory) async {
    state = const AsyncLoading();
    try {
      final result = await _usecase.update(updatedCategory);

      if (result.success) {
        final current = state.value?.data ?? [];

        final updatedList = current
            .map((c) => c?.id == updatedCategory.id ? updatedCategory : c)
            .toList();

        final updatedResult = CommonResult<List<Category?>>(data: updatedList);

        state = AsyncData(updatedResult);
      }

      state = AsyncError(result, StackTrace.current);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // Métodos de leitura de estado ainda podem existir aqui, se necessário
  Category? getCategoryById(int id) {
    try {
      return state.value!.data!.firstWhere((c) => c!.id == id);
    } catch (_) {
      return null;
    }
  }

  String getCategoryName(int id) => getCategoryById(id)?.name ?? 'Desconhecida';

  @override
  Future<CommonResult<List<Category?>?>> build() async {
    final usecaseAsync = await ref.watch(categoryUsecaseProvider.future);
    _usecase = usecaseAsync;
    final result = await _usecase.getAll();
    return result;
  }
}
