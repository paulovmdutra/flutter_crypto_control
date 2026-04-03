import 'package:flutter/services.dart';

class PhoneInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    String digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty) {
      // Campo vazio: retorna texto vazio e cursor na posição 0
      return TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    if (digits.length > 11) {
      digits = digits.substring(0, 11);
    }

    StringBuffer buffer = StringBuffer();
    int selectionIndex = digits.length;

    buffer.write('(');
    int i = 0;
    for (; i < digits.length; i++) {
      if (i == 2) buffer.write(') ');
      if ((digits.length > 10 && i == 7) || (digits.length <= 10 && i == 6)) {
        buffer.write('-');
      }
      buffer.write(digits[i]);
    }
    selectionIndex = buffer.length;

    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
