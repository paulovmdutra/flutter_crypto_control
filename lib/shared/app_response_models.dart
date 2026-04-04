// --- CLASSES AUXILIARES ---

// (Assumindo que sua classe Error contém o FlattenedException que você já criou)
import 'package:flutter_crypto_control/shared/flattened_exception.dart';

class ErrorCode {
  static const int general = 1000;
  static const int validation = 1001;
  static const int notFound = 1002;
  static const int unauthorized = 1003;
  static const int conflict = 1004;
  static const int database = 1005;
}

/// ----------------------------------------------------
/// 2. CÓDIGOS DE STATUS HTTP (Mantido para factories do CommonError)
/// ----------------------------------------------------
/// Códigos de status internos da aplicação, usados para complementar os StatusCodes HTTP.
///
/// Padrão sugerido:
/// 1xxx → Erros de validação
/// 2xxx → Erros de domínio/negócio
/// 3xxx → Autenticação/autorização
/// 4xxx → Integrações externas
/// 5xxx → Erros internos/desconhecidos
class AppStatusCodes {
  // =============================
  // 1xxx - Validação
  // =============================

  /// Campos obrigatórios não foram informados ou são inválidos.
  static const int validationError = 1000;

  // =============================
  // 2xxx - Domínio / Regras de Negócio
  // =============================

  /// Recurso não encontrado no domínio da aplicação.
  static const int domainNotFound = 2000;

  /// Conflito ao tentar criar ou atualizar um recurso.
  static const int domainConflict = 2001;

  /// Operação de negócio inválida.
  static const int invalidDomainOperation = 2002;

  /// Dados de entrada não passaram em alguma regra de validação de negócio.
  static const int domainValidationError = 2003;

  /// Dados foram processados com sucesso.
  static const int domainOK = 2004;

  /// Dados foram criados com sucesso.
  static const int domainCreated = 2005;

  /// Alguma operação de domínio falhou por algum motivo não previsto.
  static const int domainError = 2006;

  // =============================
  // 3xxx - Segurança / Autenticação / Autorização
  // =============================

  /// Token ausente ou inválido.
  static const int authTokenInvalid = 3000;

  /// Token expirado.
  static const int authTokenExpired = 3001;

  /// Acesso negado (sem permissão para o recurso).
  static const int authForbidden = 3002;

  /// Acesso não autorizado.
  static const int unauthorizedAccess = 3003;

  // =============================
  // 4xxx - Integrações externas
  // =============================

  /// Falha ao chamar um serviço externo.
  static const int externalServiceError = 4000;

  /// Timeout ao chamar um serviço externo.
  static const int externalServiceTimeout = 4001;

  /// Resposta inválida de um serviço externo.
  static const int externalServiceInvalidResponse = 4002;

  // =============================
  // 5xxx - Erros internos
  // =============================

  /// Erro interno inesperado.
  static const int internalError = 5000;

  /// Erro de banco de dados.
  static const int databaseError = 5001;

  /// Erro desconhecido genérico.
  static const int unknown = 5999;
}

class HttpStatusMapper {
  static int toHttpStatus(int appStatusCode) {
    // 1xxx — Validação → 400 Bad Request
    if (appStatusCode >= 1000 && appStatusCode <= 1999) {
      return 400; // Bad Request
    }

    switch (appStatusCode) {
      // =============================
      // 2xxx — Domínio
      // =============================
      case AppStatusCodes.domainOK:
        return 200; // OK

      case AppStatusCodes.domainCreated:
        return 201; // Created

      case AppStatusCodes.domainNotFound:
        return 404; // Not Found

      case AppStatusCodes.domainConflict:
        return 409; // Conflict

      case AppStatusCodes.domainValidationError:
      case AppStatusCodes.domainError:
        return 400; // Bad Request

      case AppStatusCodes.invalidDomainOperation:
        return 422; // Unprocessable Entity

      // =============================
      // 3xxx — Segurança / Autenticação / Autorização
      // =============================
      case AppStatusCodes.authTokenInvalid:
      case AppStatusCodes.authTokenExpired:
      case AppStatusCodes.unauthorizedAccess:
        return 401; // Unauthorized

      case AppStatusCodes.authForbidden:
        return 403; // Forbidden

      // =============================
      // 4xxx — Integrações externas
      // =============================
      case AppStatusCodes.externalServiceTimeout:
        return 504; // Gateway Timeout

      case AppStatusCodes.externalServiceError:
      case AppStatusCodes.externalServiceInvalidResponse:
        return 502; // Bad Gateway

      // =============================
      // 5xxx — Erros internos
      // =============================
      case AppStatusCodes.internalError:
      case AppStatusCodes.databaseError:
      case AppStatusCodes.unknown:
        return 500; // Internal Server Error

      // =============================
      // Qualquer código não mapeado
      // =============================
      default:
        return 500; // Internal Server Error
    }
  }
}

class Error {
  final int code; // Código de erro principal
  final String message;
  final String? details;
  final FlattenedException? exception; // Se houver uma exceção serializada

  Error({
    required this.code,
    required this.message,
    this.exception,
    this.details,
  });

  factory Error.fromJson(Map<String, dynamic> json) {
    return Error(
      code: json['code'] as int? ?? -1,
      message:
          json['message'] as String? ?? 'Erro de comunicação desconhecido.',
      exception: json['exception'] != null
          ? FlattenedException.fromJson(
              json['exception'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

class CommonError extends Error {
  CommonError({required super.code, required super.message, super.exception});

  // 🔸 Erro genérico
  factory CommonError.general({
    String? message = "An unexpected error occurred.",
    FlattenedException? ex,
  }) => CommonError(
    code: AppStatusCodes.internalError,
    message: message!,
    exception: ex,
  );

  // 🔸 Erro de validação
  factory CommonError.validation(String message) =>
      CommonError(code: AppStatusCodes.domainValidationError, message: message);

  // 🔸 Não encontrado
  factory CommonError.notFound({String message = "Resource not found."}) =>
      CommonError(code: AppStatusCodes.domainNotFound, message: message);

  // 🔸 Não autorizado
  factory CommonError.unauthorized({
    String message = "You are not authorized to perform this action.",
  }) => CommonError(code: AppStatusCodes.authForbidden, message: message);

  // 🔸 Conflito (ex: dados duplicados)
  factory CommonError.conflict({String message = "A conflict occurred."}) =>
      CommonError(code: AppStatusCodes.domainConflict, message: message);

  factory CommonError.unknown(String message) =>
      CommonError(code: AppStatusCodes.unknown, message: message);

  // 🔸 Erro de banco de dados
  factory CommonError.database({
    String message = "A database error occurred.",
    FlattenedException? ex,
  }) => CommonError(
    code: AppStatusCodes.databaseError,
    message: message,
    exception: ex,
  );
}

// Representa uma mensagem (informativa, aviso, erro)
class AppMessage {
  final int code;
  final String message;
  final String type; // Ex: 'INFO', 'WARNING', 'ERROR'

  AppMessage({required this.code, required this.message, required this.type});

  factory AppMessage.fromJson(Map<String, dynamic> json) {
    return AppMessage(
      code: json['code'] as int? ?? 0,
      message: json['message'] as String? ?? '',
      type: json['type'] as String? ?? 'INFO',
    );
  }
}

// Classe de mensagem comum para criação (Seu CommonMessage.Other(message))
class CommonMessage extends AppMessage {
  CommonMessage.other(String message)
    : super(code: 9999, message: message, type: 'OTHER');
}

/// Equivalente ao CallResult (não genérico) em C#.
/// Representa o resultado de uma operação que não retorna dados específicos.
class CallResult {
  final Error? error;

  // Se 'error' for nulo, a chamada foi um sucesso.
  bool get success => error == null;

  CallResult({this.error});

  // Construtor nomeado para sucesso
  factory CallResult.success() => CallResult(error: null);

  // Construtor nomeado para falha
  factory CallResult.fail(Error error) => CallResult(error: error);

  @override
  String toString() {
    return success ? 'Success' : 'Error: ${error!.message}';
  }
}

/// Equivalente ao CommonResult<T> em C#.
/// Usa composição para replicar o comportamento de herança do CallResult.
class CommonResult<T> {
  // Propriedades herdadas (via composição implícita)
  final Error? error;

  // Propriedades do CallResult<T>
  final T? data;
  final List<AppMessage> messages;

  // Propriedades do CommonResult<T>
  final int? code;
  final int? statusCode;
  final String message;
  final DateTime timestamp;

  bool get success => error == null;

  CommonResult({
    this.data,
    this.error,
    this.messages = const [],
    this.code,
    int? statusCode,
    String? message,
  }) : message = message ?? '',
       statusCode = statusCode ?? 0,
       timestamp = DateTime.now();

  // --- FACTORY METHODS (SIMILAR AOS STATIC C#) ---

  // Construtor de Sucesso com dados (Equivalent to CommonResult<T>.SuccessResult)
  factory CommonResult.success({
    required T data,
    String message = '',
    statusCode = AppStatusCodes.domainOK,
  }) {
    return CommonResult<T>(
      data: data,
      message: message,
      error: null,
      statusCode: statusCode,
    );
  }

  // Construtor de Falha (Equivalent to CommonResult<T>.FailResult)
  factory CommonResult.fail({
    required Error error,
    String message = '',
    int? statusCode = 0,
  }) {
    return CommonResult<T>(
      error: error,
      message: message,
      data: null,
      statusCode: statusCode,
    );
  }

  // --- DESERIALIZAÇÃO (fromJson) ---

  // NOTE: Deserialização de genéricos (T) requer que você passe um parser/builder
  factory CommonResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json)? fromJsonT, // Função para construir T
  ) {
    try {
      // 1. Deserializar o Error, se existir
      final errorJson = json['error'] as Map<String, dynamic>?;
      final Error? error = errorJson != null
          ? Error.fromJson(
              errorJson,
            ) // Assumindo que Error.fromJson lança exceção se for inválido
          : null;

      // 2. Deserializar Data, se existir e não for um erro
      T? data;
      if (fromJsonT != null && json['data'] != null && error == null) {
        // **TRATAMENTO DE ERRO:** O 'try-catch' principal já cobre a falha aqui.
        // Chama a função de parse específica para o tipo T
        data = fromJsonT(json['data']);
      }

      // 3. Deserializar Messages (incluir try-catch ou usar '?' e '?? []' é mais robusto)
      final messagesJson = json['messages'] as List<dynamic>?;
      final List<AppMessage> messages =
          messagesJson
              ?.map((m) {
                // Pode ser útil um try-catch interno para cada AppMessage,
                // ou apenas ignorar itens malformados
                try {
                  return AppMessage.fromJson(m as Map<String, dynamic>);
                } catch (_) {
                  // Logar ou ignorar a mensagem malformada
                  return null; // Será removido no .whereType<AppMessage>()
                }
              })
              .whereType<
                AppMessage
              >() // Remove itens nulos se houver falha na iteração
              .toList() ??
          [];

      return CommonResult<T>(
        data: data,
        error: error,
        messages: messages,
        code: json['code'] as int?,
        message: json['message'] as String?,
      );
    } catch (e, stackTrace) {
      // CATCH PRINCIPAL: Captura qualquer erro de formato/casting que o Dart/JSON lança
      // (e.g., tipo errado, fromJsonT falhou, campo 'code' não é int)

      // Logar o erro e stackTrace para debug
      print('Erro de Deserialização JSON: $e');
      print('StackTrace: $stackTrace');

      // Retorna um CommonResult.fail padronizado para o erro de formato/parsing
      return CommonResult<T>.fail(
        error: Error(
          // Use uma classe/código de erro específico para erros de formato local
          code: AppStatusCodes.internalError,
          message: 'Falha ao processar o JSON da API. Formato inesperado.',
        ),
        statusCode: 500, // Código de erro interno para parsing
        message: 'Erro interno de processamento.',
      );
    }
  }
}
