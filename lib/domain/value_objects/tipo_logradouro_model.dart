import 'package:flutter/material.dart';

enum TipoLogradouro {
  rua,
  avenida,
  travessa,
  alameda,
  rodovia,
  viela,
  estrada,
  largo,
  praca,
  outro,
}

class TipoLogradouroModel {
  final TipoLogradouro tipo;
  final String nome;
  final IconData icone;

  const TipoLogradouroModel({
    required this.tipo,
    required this.nome,
    required this.icone,
  });

  static List<TipoLogradouroModel> todos = [
    TipoLogradouroModel(
      tipo: TipoLogradouro.rua,
      nome: 'Rua',
      icone: Icons.map,
    ),
    TipoLogradouroModel(
      tipo: TipoLogradouro.avenida,
      nome: 'Avenida',
      icone: Icons.traffic,
    ),
    TipoLogradouroModel(
      tipo: TipoLogradouro.travessa,
      nome: 'Travessa',
      icone: Icons.alt_route,
    ),
    TipoLogradouroModel(
      tipo: TipoLogradouro.alameda,
      nome: 'Alameda',
      icone: Icons.nature_people,
    ),
    TipoLogradouroModel(
      tipo: TipoLogradouro.rodovia,
      nome: 'Rodovia',
      icone: Icons.directions_car,
    ),
    TipoLogradouroModel(
      tipo: TipoLogradouro.viela,
      nome: 'Viela',
      icone: Icons.fork_right,
    ),
    TipoLogradouroModel(
      tipo: TipoLogradouro.estrada,
      nome: 'Estrada',
      icone: Icons.directions,
    ),
    TipoLogradouroModel(
      tipo: TipoLogradouro.largo,
      nome: 'Largo',
      icone: Icons.location_city,
    ),
    TipoLogradouroModel(
      tipo: TipoLogradouro.praca,
      nome: 'Praça',
      icone: Icons.park,
    ),
    TipoLogradouroModel(
      tipo: TipoLogradouro.outro,
      nome: 'Outro',
      icone: Icons.location_on,
    ),
  ];

  static TipoLogradouroModel fromTipo(TipoLogradouro tipo) {
    return todos.firstWhere((t) => t.tipo == tipo);
  }
}
