/// Exception base para todos os exceptions da aplicação e para ocorrência de erros
/// gerais ocorridas na aplicação
class ApplicationException implements Exception {
  final Exception? exception;
  late String? message;

  ApplicationException({this.exception, this.message});

  @override
  String toString() {
    if (message != null) {
      return message.toString();
    } else {
      return exception.toString();
    }
  }

  String error() => toString();
}

/// Thrown by the Domain when a problem occurs.
class DomainException extends ApplicationException {
  DomainException({super.exception, super.message});
}

/// Thrown by the repository when a problem occurs.
class RepositoryException extends DomainException {
  RepositoryException({super.exception, super.message});
}

/// Thrown by the Service when a problem occurs.
class ServiceException extends ApplicationException {
  ServiceException({super.exception, super.message});
}

/// Base Result class
/// [S] represents the type of the success value
/// [E] should be [Exception] or a subclass of it
sealed class Result<S, E extends Exception> {
  const Result();
}

final class Success<S, E extends Exception> extends Result<S, E> {
  const Success(this.value);
  final S value;
}

final class Failure<S, E extends Exception> extends Result<S, E> {
  const Failure(this.exception);
  final E exception;
}
