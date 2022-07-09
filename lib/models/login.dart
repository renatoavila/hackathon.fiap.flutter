class Login {

  Login({
    required this.id,
    required this.chave,
    required this.email,
    required this.senha,
    required this.ativo,
    required this.atendente,
    required this.dataCadastro,
    required this.dataAtualizacao,
  });

  int id;
  String chave;
  String email;
  String senha;
  bool ativo;
  bool atendente;
  DateTime dataCadastro;
  DateTime dataAtualizacao;
}
