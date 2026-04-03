/// Classe genérica para representar estados assíncronos
/// Inspirada no AsyncValue do Riverpod, mas desacoplada.
abstract class ViewAsync<T> {
  const ViewAsync();

  /// Executa callbacks dependendo do estado atual
  R when<R>({
    required R Function() loading,
    required R Function(Object error, StackTrace? stackTrace) error,
    required R Function(T data) data,
  });

  /// Conveniência: verifica se está carregando
  bool get isLoading => this is ViewAsyncLoading<T>;

  /// Conveniência: verifica se tem erro
  bool get hasError => this is ViewAsyncError<T>;

  /// Conveniência: verifica se tem dados
  bool get hasData => this is ViewAsyncData<T>;
}

/// Estado de carregamento
class ViewAsyncLoading<T> extends ViewAsync<T> {
  const ViewAsyncLoading();

  @override
  R when<R>({
    required R Function() loading,
    required R Function(Object error, StackTrace? stackTrace) error,
    required R Function(T data) data,
  }) {
    return loading();
  }
}

/// Estado de erro
class ViewAsyncError<T> extends ViewAsync<T> {
  final Object error;
  final StackTrace? stackTrace;

  const ViewAsyncError(this.error, [this.stackTrace]);

  @override
  R when<R>({
    required R Function() loading,
    required R Function(Object error, StackTrace? stackTrace) error,
    required R Function(T data) data,
  }) {
    return error(this.error, stackTrace);
  }
}

/// Estado de sucesso (dados disponíveis)
class ViewAsyncData<T> extends ViewAsync<T> {
  final T value;

  const ViewAsyncData(this.value);

  @override
  R when<R>({
    required R Function() loading,
    required R Function(Object error, StackTrace? stackTrace) error,
    required R Function(T data) data,
  }) {
    return data(value);
  }
}
