/*import 'package:flutter/material.dart';
import 'package:flutter_controle_enderecos/domain/value_objects/tipo_logradouro_model.dart';

class DropdownButtonTipoLogradouro extends StatefulWidget {
  final Function(TipoLogradouro) onChanged;
  final TipoLogradouro? valorInicial;

  const DropdownButtonTipoLogradouro({
    super.key,
    required this.onChanged,
    this.valorInicial,
  });

  @override
  State<DropdownButtonTipoLogradouro> createState() =>
      _DropdownButtonTipoLogradouroState();
}

class _DropdownButtonTipoLogradouroState
    extends State<DropdownButtonTipoLogradouro> {
  late TipoLogradouro? _selecionado;

  @override
  void initState() {
    super.initState();
    _selecionado = widget.valorInicial;
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<TipoLogradouro>(
      value: _selecionado,
      decoration: const InputDecoration(
        labelText: 'Tipo de Logradouro',
        border: OutlineInputBorder(),
      ),
      items: TipoLogradouroModel.todos.map((modelo) {
        return DropdownMenuItem<TipoLogradouro>(
          value: modelo.tipo,
          child: Row(
            children: [
              Icon(modelo.icone, size: 18),
              const SizedBox(width: 8),
              Text(modelo.nome),
            ],
          ),
        );
      }).toList(),
      onChanged: (novo) {
        if (novo != null) {
          setState(() => _selecionado = novo);
          widget.onChanged(novo);
        }
      },
    );
  }
}
*/
