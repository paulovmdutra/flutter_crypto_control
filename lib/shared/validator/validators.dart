import 'package:flutter_crypto_control/shared/validator/validation_result.dart';
import 'package:flutter_crypto_control/shared/validator/validation_rule.dart';

/// Estratégia para validação de E-mail
class EmailValidationRule implements ValidationRule {
  final RegExp _emailExp = RegExp(
    r"^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$",
  );

  @override
  ValidationResult validate(value) {
    if (value == null || value.isEmpty) {
      // Falha de campo obrigatório
      return ValidationResult.failure('O campo de e-mail é obrigatório.');
    }
    if (!_emailExp.hasMatch(value)) {
      // Falha de formato
      return ValidationResult.failure('O e-mail fornecido é inválido!');
    }

    // Sucesso
    return ValidationResult.success();
  }
}

/// Estratégia para validação de Login
class LoginValidationRule implements ValidationRule {
  // Baseado na sua regex original
  final RegExp _loginExp = RegExp(
    r'^[a-zA-Z](?!.*[._\-@]{2})[a-zA-Z0-9._\-@]{2,23}[a-zA-Z0-9]$',
  );

  @override
  ValidationResult validate(value) {
    if (value == null || value.isEmpty) {
      return ValidationResult.failure('O login é obrigatório.');
    }

    if (!_loginExp.hasMatch(value)) {
      // Aqui você pode retornar um código de erro ou uma mensagem detalhada
      return ValidationResult.failure(
        'Login inválido. Deve começar com letra, ter entre 4 e 25 caracteres e não ter caracteres especiais repetidos.',
      );
    }

    return ValidationResult.success();
  }
}

/// Estratégia para validação de Senha
class RequiredFieldValidationRule implements ValidationRule {
  final String fieldName;

  RequiredFieldValidationRule(this.fieldName);

  @override
  ValidationResult validate(value) {
    if (value == null || value.isEmpty) {
      return ValidationResult.failure('O campo $fieldName é obrigatório.');
    }
    return ValidationResult.success();
  }
}

/// O Contexto que usa a estratégia de validação.
class ValidatorContext {
  ValidationRule _strategy;

  ValidatorContext(this._strategy);

  // Delega a chamada para a estratégia configurada, retornando ValidationResult
  ValidationResult executeValidation(String? value) {
    return _strategy.validate(value);
  }
}
