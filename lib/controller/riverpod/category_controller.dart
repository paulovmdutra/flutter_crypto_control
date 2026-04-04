import 'package:flutter_crypto_control/controller/riverpod/crud_async_notifier.dart';
import 'package:flutter_crypto_control/domain/domain_services/interfaces/icrud_usecase.dart';
import 'package:flutter_crypto_control/domain/models/category.dart';
import 'package:flutter_crypto_control/pages/providers/category_providers.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_crypto_control/view_model/category_view_model.dart';

class CategoryController
    extends CrudAsyncNotifier<Category, CategoryViewModel> {
  late final ICrudUsecase<Category> _usecase;

  // 1. Opcionalmente sobrescrevemos o build nativo apenas para poder aguardar (await)
  // o provider assíncrono antes de entregar para o motor base.
  @override
  Future<CommonResult<List<CategoryViewModel?>?>> build() async {
    // Injeção de dependência assíncrona do Riverpod
    _usecase = await ref.watch(categoryUsecaseProvider.future);

    // Devolve o controle para a inicialização padrão da base (que já tem os try/catches de GetAll)
    return super.build();
  }

  // 2. Aponta para o UseCase resolvido.
  @override
  ICrudUsecase<Category> get usecase => _usecase;

  // 3. Regra de negócio explícita de identificador unívoco para edições e exclusões locais.
  @override
  bool isSame(CategoryViewModel current, Category entity) {
    return current.publicId == entity.publicId;
  }

  // 4. Transformação (Serializer) de como o app mostra uma Entidade para a View.
  @override
  CategoryViewModel fromEntity(Category entity) {
    return CategoryViewModel.fromEntityToViewModel(entity);
  }

  // 5. Transformação de como a View entrega seus dados sujos para gravar o BD (Entidade).
  @override
  Category toEntity(CategoryViewModel viewModel) {
    return viewModel.toEntity();
  }

  // Métodos de leitura de estado ainda podem existir aqui limpamente (Opcionais)
  CategoryViewModel? getCategoryById(String publicId) {
    try {
      return state.value?.data?.firstWhere((c) => c?.publicId == publicId);
    } catch (_) {
      return null;
    }
  }
  
  // Basta prever isso dentro da classe do controller:
  @override
  bool isNew(CategoryViewModel item) {
    // Se não tem PublicId, o registro é totalmente novo!
    return item.publicId == null || item.publicId.isEmpty;
  }  

  String getCategoryName(String publicId) =>
      getCategoryById(publicId)?.name ?? 'Desconhecida';
}

/*
    extends AsyncNotifier<CommonResult<List<CategoryViewModel?>?>> {
  
  late final ICrudUsecase<Category> _usecase;

  CategoryController();

  // Carrega categorias ao iniciar
  Future<void> loadCategories() async {
    state = const AsyncLoading();
    try {
      final result = await _usecase.getAll();
      List<CategoryViewModel?>? categoryViewModels = result.data
          ?.map((c) => CategoryViewModel.fromEntityToViewModel(c!))
          .toList();
      state = AsyncData(
        categoryViewModels != null
            ? CommonResult<List<CategoryViewModel?>?>.success(
                data: categoryViewModels,
              )
            : CommonResult<List<CategoryViewModel?>?>.success(data: []),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> addCategory(CategoryViewModel newCategory) async {
    try {
      state = const AsyncLoading();
      var entity = newCategory.toEntity();
      final result = await _usecase.add(entity);

      if (result.success) {
        final current = state.value?.data ?? [];

        final updatedList = List<CategoryViewModel?>.from(current)
          ..add(CategoryViewModel.fromEntityToViewModel(result.data!));

        final resultList = CommonResult<List<CategoryViewModel?>?>.success(
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
        final updatedList = List<CategoryViewModel?>.from(current)
          ..removeWhere((c) => c?.publicId == result.data?.publicId);

        final resultList = CommonResult<List<CategoryViewModel?>?>.success(
          data: updatedList,
        );

        state = AsyncData(resultList);
      } else {
        var errorMessage = "Failed to delete category";
        if (result.error != null) {
          errorMessage = result.error!.message;
        }
        state = AsyncError(errorMessage, StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateCategory(CategoryViewModel updatedCategory) async {
    state = const AsyncLoading();
    try {
      final result = await _usecase.update(updatedCategory.toEntity());

      if (result.success) {
        final current = state.value?.data ?? [];

        final updatedList = current
            .map(
              (c) => c?.publicId == updatedCategory.publicId
                  ? CategoryViewModel.fromEntityToViewModel(
                      updatedCategory.toEntity(),
                    )
                  : c,
            )
            .toList();

        final updatedResult = CommonResult<List<CategoryViewModel?>?>.success(
          data: updatedList,
        );

        state = AsyncData(updatedResult);
      } else {
        state = AsyncError(result, StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  // Métodos de leitura de estado ainda podem existir aqui, se necessário
  CategoryViewModel? getCategoryById(String publicId) {
    try {
      return state.value!.data!.firstWhere((c) => c!.publicId == publicId);
    } catch (_) {
      return null;
    }
  }

  String getCategoryName(String publicId) =>
      getCategoryById(publicId)?.name ?? 'Desconhecida';

  @override
  Future<CommonResult<List<CategoryViewModel?>?>> build() async {
    final usecaseAsync = await ref.watch(categoryUsecaseProvider.future);
    _usecase = usecaseAsync;
    final result = await _usecase.getAll();
    List<CategoryViewModel?>? categoryViewModels = result.data
        ?.map((c) => CategoryViewModel.fromEntityToViewModel(c!))
        .toList();
    return CommonResult<List<CategoryViewModel?>?>.success(
      data: categoryViewModels,
    );
  }
}*/
