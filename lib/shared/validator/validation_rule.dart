import 'package:flutter_crypto_control/shared/validator/validation_result.dart';

abstract class ValidationRule<T> {
  ValidationResult validate(T value);
}
