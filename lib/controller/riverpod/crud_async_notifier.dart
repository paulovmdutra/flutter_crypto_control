import 'package:flutter_crypto_control/domain/domain_services/interfaces/icrud_usecase.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Define o comportamento unificado de operações C.R.U.D para Notifiers do Riverpod.
/// Esta classe é abstrata e deve ser superclasse de qualquer controller que exija
/// a gerência e manutenção de lista na memória reativa da UI.
abstract class CrudAsyncNotifier<TEntity, TViewModel>
    extends AsyncNotifier<CommonResult<List<TViewModel?>?>> {
  /// O caso de uso base para injeção e manipulação do banco.
  ICrudUsecase<TEntity> get usecase;

  /// Função para converter a Entidade do domínio para a ViewModel estéril (consumida pela UI).
  TViewModel fromEntity(TEntity entity);

  /// Função para converter a ViewModel editada (ou nova) da UI para o formato bruto de Entidade.
  TEntity toEntity(TViewModel viewModel);

  /// Função estrita de identificação de instâncias em memória, crucial paramostrar
  /// se a alteração feita na base ocorreu em um item específico da memória usando publicId ou IDs locais.
  bool isSame(TViewModel current, TEntity entity);

  /// Carrega a listagem inicial do repositório/banco de dados informando UI sobre os delays (`AsyncLoading`)
  Future<void> loadData() async {
    state = const AsyncLoading();
    try {
      final result = await usecase.getAll();
      List<TViewModel?>? viewModels = result.data
          ?.map((e) => fromEntity(e!))
          .toList();
      state = AsyncData(
        viewModels != null
            ? CommonResult<List<TViewModel?>?>.success(data: viewModels)
            : CommonResult<List<TViewModel?>?>.success(data: []),
      );
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Conduz o fluxo completo de adição, manipulando in-memory sem exigência de reload desnecessário (Otimizado).
  Future<void> add(TViewModel newItem) async {
    try {
      state = const AsyncLoading();
      final result = await usecase.add(toEntity(newItem));

      if (result.success) {
        final current = state.value?.data ?? [];
        final updatedList = List<TViewModel?>.from(current)
          ..add(fromEntity(result.data!));

        state = AsyncData(
          CommonResult<List<TViewModel?>?>.success(data: updatedList),
        );
        return;
      }
      state = AsyncError(result, StackTrace.current);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Conduz a deleção comunicando para o UseCase e, em caso de sucesso, removendo o alvo da lista atual sem reload extra.
  Future<void> delete(TEntity entity) async {
    try {
      state = const AsyncLoading();
      final result = await usecase.delete(entity);

      if (result.success && result.data != null) {
        final current = state.value?.data ?? [];
        final updatedList = List<TViewModel?>.from(current)
          ..removeWhere((c) => c != null && isSame(c, result.data!));

        state = AsyncData(
          CommonResult<List<TViewModel?>?>.success(data: updatedList),
        );
      } else {
        var errorMessage = "Falha ao deletar o registro";
        if (result.error != null) {
          errorMessage = result.error!.message;
        }
        state = AsyncError(errorMessage, StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Atualiza o item correspondente da lista de memória e reflete as variáveis reativas da interface, persistindo o UseCase.
  Future<void> updateItem(TViewModel updatedItem) async {
    try {
      state = const AsyncLoading();
      final entity = toEntity(updatedItem);
      final result = await usecase.update(entity);

      if (result.success && result.data != null) {
        final current = state.value?.data ?? [];
        final updatedList = current.map((c) {
          if (c != null && isSame(c, result.data!)) {
            return fromEntity(result.data!);
          }
          return c;
        }).toList();

        state = AsyncData(
          CommonResult<List<TViewModel?>?>.success(data: updatedList),
        );
      } else {
        state = AsyncError(result, StackTrace.current);
      }
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  /// Build nativo do Riverpod para AsyncNotifier, unificando a carga inicial sem redigitação explícita.
  @override
  Future<CommonResult<List<TViewModel?>?>> build() async {
    // Nota: Por estarmos em uma classe genérica, em versões avançadas pode ser
    // necessário observar o provider dentro das implementações filhas ou usar dependências injetadas diretas.
    final result = await usecase.getAll();
    List<TViewModel?>? viewModels = result.data
        ?.map((e) => fromEntity(e!))
        .toList();

    return CommonResult<List<TViewModel?>?>.success(data: viewModels);
  }

  bool isNew(TViewModel item);

  Future<void> save(TViewModel item) async {
    if (isNew(item)) {
      await add(item);
    } else {
      await updateItem(item);
    }
  }
}
