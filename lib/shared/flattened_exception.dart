/// Representa uma exceção nivelada/serializada, recebida do backend C#.
/// É usada para estruturar e exibir mensagens de erro detalhadas, incluindo
/// exceções internas (InnerException).
class FlattenedException {
  // Mensagem principal da exceção.
  final String message;

  // Rastreamento da pilha (StackTrace) (opcional, pode ser nulo).
  final String? stackTrace;

  // Exceção aninhada (InnerException) (opcional, recursivo).
  final FlattenedException? inner;

  // Construtor
  FlattenedException({required this.message, this.stackTrace, this.inner});

  // --- MÉTODOS DE SERIALIZAÇÃO ---

  // Factory method para criar um objeto FlattenedException a partir de um JSON (Mapa)
  factory FlattenedException.fromJson(Map<String, dynamic> json) {
    // Tenta deserializar o InnerException recursivamente
    FlattenedException? innerException;
    if (json['inner'] != null) {
      innerException = FlattenedException.fromJson(
        json['inner'] as Map<String, dynamic>,
      );
    }

    return FlattenedException(
      message: json['message'] as String? ?? 'Ocorreu um erro desconhecido.',
      stackTrace: json['stackTrace'] as String?,
      inner: innerException,
    );
  }

  // Método opcional para converter para JSON (geralmente não usado no cliente,
  // mas mantido para integridade do modelo).
  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'stackTrace': stackTrace,
      'inner': inner?.toJson(),
    };
  }

  // Método útil para formatar a exceção completa (incluindo as internas) para log ou exibição.
  String get fullMessage {
    String msg = message;
    FlattenedException? current = inner;
    int depth = 1;

    while (current != null) {
      msg += '\n---> Inner Exception ($depth): ${current.message}';
      current = current.inner;
      depth++;
    }
    return msg;
  }
}
