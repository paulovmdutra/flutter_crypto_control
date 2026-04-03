import 'package:flutter_crypto_control/shared/flattened_exception.dart';

/// Equivalente ao Enum ErrorCode em C#
enum ErrorCode {
  general(1000),
  validation(1001),
  notFound(1002),
  unauthorized(1003),
  conflict(1004),
  database(1005);

  final int code;
  const ErrorCode(this.code);

  // Método auxiliar para buscar o Enum pelo código numérico
  static ErrorCode fromCode(int code) {
    return ErrorCode.values.firstWhere(
      (e) => e.code == code,
      orElse: () => ErrorCode.general,
    );
  }
}

class ErrorModel {
  final int? code;
  final String message;
  final FlattenedException? exception;

  ErrorCode get errorCodeType =>
      code != null ? ErrorCode.fromCode(code!) : ErrorCode.general;

  // Construtor principal (base do CommonError)
  ErrorModel({this.code, required this.message, this.exception});

  // --- FACTORY METHODS (Emulam os métodos estáticos do CommonError em C#) ---

  /// 🔸 Erro genérico
  factory ErrorModel.general({
    String message = "An unexpected error occurred.",
    FlattenedException? ex,
  }) => ErrorModel(
    code: ErrorCode.general.code, // 1000
    message: message,
    exception: ex,
  );

  /// 🔸 Erro de validação
  factory ErrorModel.validation({required String message}) => ErrorModel(
    code: ErrorCode.validation.code, // 1001
    message: message,
  );

  /// 🔸 Não encontrado
  factory ErrorModel.notFound({String message = "Resource not found."}) =>
      ErrorModel(
        code: ErrorCode.notFound.code, // 1002
        message: message,
      );

  /// 🔸 Não autorizado
  factory ErrorModel.unauthorized({
    String message = "You are not authorized to perform this action.",
  }) => ErrorModel(
    code: ErrorCode.unauthorized.code, // 1003
    message: message,
  );

  /// 🔸 Conflito (ex: dados duplicados)
  factory ErrorModel.conflict({String message = "A conflict occurred."}) =>
      ErrorModel(
        code: ErrorCode.conflict.code, // 1004
        message: message,
      );

  /// 🔸 Erro de banco de dados
  factory ErrorModel.database({
    String message = "A database error occurred.",
    FlattenedException? ex,
  }) => ErrorModel(
    code: ErrorCode.database.code, // 1005
    message: message,
    exception: ex,
  );

  // --- DESERIALIZAÇÃO (fromJson) ---
  factory ErrorModel.fromJson(Map<String, dynamic> json) {
    FlattenedException? flattenedException;
    if (json['flattenedException'] != null) {
      flattenedException = FlattenedException.fromJson(
        json['flattenedException'] as Map<String, dynamic>,
      );
    }

    return ErrorModel(
      code: json['code'] as int?,
      message:
          json['message'] as String? ??
          'Ocorreu um erro inesperado no servidor.',
      exception: flattenedException,
    );
  }
}
