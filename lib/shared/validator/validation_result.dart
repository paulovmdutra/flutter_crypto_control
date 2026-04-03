/// Representa o resultado de qualquer validação.
class ValidationResult {
  final bool isValid;
  final Object? errorContent; // Usando Object? para maior flexibilidade no erro

  ValidationResult({required this.isValid, this.errorContent});

  // Construtor de conveniência para sucesso
  factory ValidationResult.success() =>
      ValidationResult(isValid: true, errorContent: null);

  // Construtor de conveniência para falha
  factory ValidationResult.failure(Object error) =>
      ValidationResult(isValid: false, errorContent: error);
}
