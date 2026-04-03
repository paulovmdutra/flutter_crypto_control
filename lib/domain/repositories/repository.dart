import 'package:flutter_crypto_control/domain/models/entity.dart';
import 'package:flutter_crypto_control/shared/app_response_models.dart';

/// Interface genérica para operações de repositório em entidades.
/// <T> Tipo da entidade a ser manipulada.
abstract class IRepository<T extends Entity<T>> {
  /// Busca uma entidade pelo seu identificador único.
  ///
  /// @param id Identificador único da entidade (C# long se torna Dart int).
  /// @returns Entidade encontrada ou null se não existir (Future<T?>).
  Future<CommonResult<T?>> getByIdAsync(int id);

  /// Retorna todas as entidades do repositório.
  ///
  /// @returns Lista de todas as entidades (Future<List<T>>).
  Future<CommonResult<List<T?>?>> getAllAsync();

  /// Retorna uma lista paginada de entidades do repositório.
  ///
  /// @param page Número da página a ser retornada (padrão é 1).
  /// @param pageSize Quantidade de itens por página (padrão é 1000).
  /// @returns Lista de entidades correspondente à página solicitada.
  Future<CommonResult<List<T?>>> getAllPaginateAsync({
    int page = 1,
    int pageSize = 1000,
  });

  /// Busca entidades que satisfaçam uma condição específica.
  ///
  /// @param predicate Função que representa a condição de filtro.
  /// @returns Lista de entidades que atendem à condição.
  Future<CommonResult<List<T?>>> findByCondition(bool Function(T?) predicate);

  /// Busca a primeira entidade que satisfaça uma condição específica.
  ///
  /// @param predicate Função que representa a condição de filtro.
  /// @returns Entidade encontrada ou null se não existir.
  Future<CommonResult<T?>> firstOrDefaultAsync(bool Function(T?) predicate);

  /// Insere uma nova entidade no repositório.
  ///
  /// @param entity Entidade a ser inserida.
  /// @returns True se a inserção for bem-sucedida, caso contrário false.
  Future<CommonResult<T?>> addAsync(T entity);

  /// Remove uma entidade do repositório.
  ///
  /// @param entity Entidade a ser removida.
  /// @returns True se a remoção for bem-sucedida, caso contrário false.
  Future<CommonResult<T?>> deleteAsync(T entity);

  /// Atualiza uma entidade existente no repositório.
  ///
  /// @param entity Entidade a ser atualizada.
  /// @returns True se a atualização for bem-sucedida, caso contrário false.
  Future<CommonResult<T?>> updateAsync(T entity);
  Future<void> init();
}
