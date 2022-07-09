import 'dart:core';

class Chamado {

  Chamado({

    required this.id,
    required this.email,
    required this.texto,
    required this.urlImagem,
    required this.dataCadastro,
  });

  int id;
  String email;
  String texto;
  String? urlImagem;
  DateTime dataCadastro;
}
