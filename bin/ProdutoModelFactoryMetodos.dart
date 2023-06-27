import 'package:intl/intl.dart';

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

  String precoFormatado() {
    final formatador = NumberFormat.currency(locale: 'pt_BR', symbol: 'R\$');
    return formatador.format(preco);
  }

  String dataAlteracaoFormatada() {
    final formatador = DateFormat('dd/MM/yyyy');
    return formatador.format(dataAlteracao);
  }

  @override
  String toString() {
    return
        "Produto:\n"
        "Código: $codigo\n"
        "Nome: $nome\n"
        "Preço: ${precoFormatado()}\n"
        "Alteração: ${dataAlteracaoFormatada()}";
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

  print(produto);

}
