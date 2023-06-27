class Produto {
  int codigo;
  String nome;
  double preco;
  DateTime dataAlteracao;

  Produto({
    required this.codigo,
    required this.nome,
    required this.preco,
    required this.dataAlteracao,
  });

  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(
      codigo: json['codigo'],
      nome: json['descricao'],
      preco: json['preco'],
      dataAlteracao: DateTime.parse(json['dataAlteracao']),
    );
  } 
}

void main() {
  Map<String, dynamic> json = {
    'codigo': 1,
    'descricao': 'X-TUDO',
    'preco': 40.50,
    'dataAlteracao': '2023-07-27',
  };

  Produto produto = Produto.fromJson(json);

  print("Produto:\n"
        "Código: ${produto.codigo}\n"
        "Nome: ${produto.nome}\n"
        "Preço: ${produto.preco}\n"
        "Alteração: ${produto.dataAlteracao}\n"
       );

}
