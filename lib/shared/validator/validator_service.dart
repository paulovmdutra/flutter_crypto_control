import 'package:flutter_crypto_control/shared/validator/validation_result.dart';
import 'package:flutter_crypto_control/shared/validator/validation_rule.dart';

class ValidatorService {
  // Implementação do serviço de validação
  ValidationResult validateField<T>(ValidationRule<T> rule, T value) {
    return rule.validate(value);
  }
}
