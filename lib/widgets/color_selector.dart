import 'package:flutter/material.dart';
import 'package:flutter_crypto_control/widgets/widgets.dart';

/// Um widget para selecionar uma cor a partir de uma lista predefinida.
class ColorSelector extends StatefulWidget {
  /// O callback chamado quando uma nova cor é selecionada.
  /// Retorna a cor selecionada como um objeto [Color].
  final ValueChanged<Color> onColorSelected;

  /// O valor inteiro ARGB32 inicial da cor selecionada.
  final int initialColorARGB32;

  const ColorSelector({
    super.key,
    required this.onColorSelected,
    this.initialColorARGB32 = 0xFF000000, // Padrão para preto (ou outra cor)
  });

  @override
  State<ColorSelector> createState() => _ColorSelectorState();
}

class _ColorSelectorState extends State<ColorSelector> {
  late int _colorValue;

  @override
  void initState() {
    super.initState();
    // Inicializa o valor da cor com o valor inicial fornecido.
    _colorValue = widget.initialColorARGB32;
  }

  // Função para atualizar a cor selecionada e chamar o callback.
  void _selectColor(Color color) {
    final int newColorValue = color
        .toARGB32(); // Usando color.value que é o ARGB int

    // Evita reconstruções desnecessárias se a cor for a mesma
    if (_colorValue != newColorValue) {
      setState(() {
        _colorValue = newColorValue;
      });
      // Chama o callback com o objeto Color selecionado
      widget.onColorSelected(color);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Substituindo o Row com apenas o Text para simplificar, e
        // eliminando o 'spacing' do Row original, que já era redundante.
        const Text(
          'Selecione uma Cor:',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),

        // Espaçamento (substitui o 'spacing: 8' do Column original)
        const SizedBox(height: 8.0),

        Wrap(
          spacing: 8.0, // Espaço horizontal entre os itens
          runSpacing: 4.0, // Espaço vertical entre as linhas
          children: AppAvaliableColors.availableColors.map((color) {
            // Converte o objeto Color em seu valor ARGB int para comparação
            final int currentColorValue = color.toARGB32();
            final bool isSelected = _colorValue == currentColorValue;

            return GestureDetector(
              // Chama a função interna de seleção que atualiza o estado e o callback
              onTap: () => _selectColor(color),
              child: CircleAvatar(
                backgroundColor: color,
                radius: 15,
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 15)
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
