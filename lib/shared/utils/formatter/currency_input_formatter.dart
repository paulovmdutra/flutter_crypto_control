/*import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  final NumberFormat formatter = NumberFormat.currency(
    locale: 'pt_BR',
    symbol: '',
    decimalDigits: 2,
  );

  // Valor mínimo permitido (por exemplo, R$ 1,00)
  final double minValue;

  CurrencyInputFormatter({this.minValue = 1.00});

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Converte os números digitados para o valor em formato de moeda
    double value = double.parse(digitsOnly) / 100;

    // Se o valor for menor que o mínimo, retorna o valor anterior (não permite)
    if (value < minValue) {
      return oldValue;
    }

    // Formata o valor para exibição
    String newText = formatter.format(value);

    return TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}
*/