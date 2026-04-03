bool emailRegexValidator(String? email) {
  final RegExp emailExp = RegExp(
    r"^[a-zA-Z0-9]+([._%+-]?[a-zA-Z0-9]+)*@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$",
  );

  bool isValid = true;
  if (email == null || email.isEmpty || !emailExp.hasMatch(email)) {
    isValid = false;
  }

  return isValid;
}

bool isValidLogin(String login) {
  /*
    ^[a-zA-Z]: Indica que o nome de usuário deve começar com uma letra, seja minúscula (a-z) ou maiúscula (A-Z).
    (?!.*[._@]{2}): Negative Lookahead para garantir que não há dois caracteres especiais consecutivos.
    [a-zA-Z0-9._@-]{2,23}: Permite letras, números e caracteres especiais por 2 a 23 caracteres.
    [a-zA-Z0-9]$: Garante que o nome de usuário termine com uma letra ou número.
  */
  const regexString =
      r'^[a-zA-Z](?!.*[._\-@]{2})[a-zA-Z0-9._\-@]{2,23}[a-zA-Z0-9]$';
  final regex = RegExp(regexString);

  bool isValid = true;
  if (login.isEmpty || !regex.hasMatch(login)) {
    isValid = false;
  }

  return isValid;
}

bool isCurrencyValidator(String? value, {double minValue = 0.0}) {
  // Valida se o valor digitado é maior que o mínimo
  if (value != null && value.isNotEmpty) {
    String cleanValue = value.replaceAll(RegExp(r'[^0-9]'), '');
    double numericValue = double.parse(cleanValue) / 100;
    if (numericValue < minValue) {
      return false;
    }
  }
  return true;
}

bool isEmpty(String? value) {
  return (value == null || value.isEmpty);
}

String? ufValidator(String? value) {
  if (isEmpty(value)) {
    return 'A sigla (UF) é obrigatória';
  }
  if (value!.trim().length != 2) {
    return 'A UF deve conter exatamente 2 letras';
  }
  return null;
}

String? emailValidator(String? value) {
  if (value == null || value.isEmpty) return 'Campo obrigatório.';
  if (!emailRegexValidator(value)) return 'Email inválido!';
  return null;
}

String? fieldValidator(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Campo obrigatório';
  }
  return null;
}
