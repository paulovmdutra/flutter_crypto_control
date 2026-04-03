import 'package:flutter/material.dart';

enum TipoEndereco {
  residencial,
  comercial,
  industrial,
  rural,
  publico,
  outro,
}

class TipoEnderecoModel {
  final TipoEndereco tipo;
  final String nome;
  final IconData icone;

  const TipoEnderecoModel({
    required this.tipo,
    required this.nome,
    required this.icone,
  });

  static List<TipoEnderecoModel> todos = [
    TipoEnderecoModel(
      tipo: TipoEndereco.residencial,
      nome: 'Residencial',
      icone: Icons.home,
    ),
    TipoEnderecoModel(
      tipo: TipoEndereco.comercial,
      nome: 'Comercial',
      icone: Icons.business,
    ),
    TipoEnderecoModel(
      tipo: TipoEndereco.industrial,
      nome: 'Industrial',
      icone: Icons.factory,
    ),
    TipoEnderecoModel(
      tipo: TipoEndereco.rural,
      nome: 'Rural',
      icone: Icons.park,
    ),
    TipoEnderecoModel(
      tipo: TipoEndereco.publico,
      nome: 'Público',
      icone: Icons.account_balance,
    ),
    TipoEnderecoModel(
      tipo: TipoEndereco.outro,
      nome: 'Outro',
      icone: Icons.location_on,
    ),
  ];

  static TipoEnderecoModel fromTipo(TipoEndereco tipo) {
    return todos.firstWhere((t) => t.tipo == tipo);
  }
}
