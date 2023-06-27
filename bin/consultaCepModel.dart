import 'dart:convert';
import 'package:http/http.dart' as http; 

class Endereco {
  final String cep;
  final String logradouro;
  final String complemento;
  final String bairro;
  final String localidade;
  final String uf;
  final String ibge;
  final String gia;
  final String ddd;
  final String siafi;

  Endereco( {    
    required this.cep,
    required this.logradouro,
    required this.complemento, 
    required this.bairro,
    required this.localidade,
    required this.uf,
    required this.ibge, 
    required this.gia, 
    required this.ddd, 
    required this.siafi,
  });

  factory Endereco.fromJson(Map<String, dynamic> json) {
    return Endereco(
      cep: json['cep'],
      logradouro: json['logradouro'],
      complemento: json['complemento'],
      bairro: json['bairro'],
      localidade: json['localidade'],
      uf: json['uf'],
      ibge: json['ibge'],
      gia: json['gia'],
      ddd: json['ddd'],
      siafi: json['siafi'],    

    );
  }

  @override
  String toString() {
    return 'CEP: $cep\n'
        'Logradouro: $logradouro\n'
        'Complemento: $complemento\n'
        'Bairro: $bairro\n'
        'Localidade: $localidade\n'
        'ibge: $ibge\n'
        'UF: $uf\n';
  }
}

Future<void> main() async {
  final url = Uri.parse('https://viacep.com.br/ws/17509060/json/');

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final jsonResult = jsonDecode(response.body);
    final endereco = Endereco.fromJson(jsonResult);
    print(endereco);
  }
}