import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

void main() {   
  /*

  retornaNomesPaises().then((nomePais) { ... }): 
      Aqui, está sendo chamada a função retornaNomesPaises(), que retorna um objeto do 
      tipo Future<List<String>>. 
  O método then() é encadeado ao Future retornado. 
      Ele registra um callback que será invocado quando o valor do Future estiver disponível. 
      O callback é uma função anônima definida como (nomePais) { ... }, que recebe 
      a lista de nomes de países como argumento.   
*/
  retornaNomesPaises().then((nomePais) {
    // print(nomePais);
    /*
      final nomesFormatados = nomePais.join('\n');: 
          Dentro do callback, a lista de nomes de países é formatada usando o método join('\n'). 
          Isso concatena os elementos da lista em uma única string, utilizando o caractere de 
          quebra de linha (\n) como separador. 
          O resultado é armazenado na variável nomesFormatados.
    */
    final nomesFormatados = nomePais.join('\n');
    print(nomesFormatados);
    /*
    print(nomesFormatados);: 
        A string formatada contendo os nomes de países é impressa usando o método print(). 
        Cada nome de país será exibido em uma linha separada, devido ao uso do caractere 
        de quebra de linha (\n).
    */
    print(nomesFormatados);
  }).catchError((error) {
    print('Erro: $error');
  });

}

Future<List<String>> retornaNomesPaises() async {
  // são tres aspas simples
  /*
      as três aspas (''') em Dart são usadas para criar uma string multilinha. 
      Uma string multilinha é uma string que abrange várias linhas de código sem 
      a necessidade de usar caracteres de escape ou concatenação de strings.
  */
  // final soapEnvelope = '''<?xml version="1.0" encoding="utf-8"?>
  //     <soap12:Envelope xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
  //       <soap12:Body>
  //         <ListOfCountryNamesByName xmlns="http://www.oorsprong.org/websamples.countryinfo">
  //         </ListOfCountryNamesByName>
  //       </soap12:Body>
  //     </soap12:Envelope>''';

  //Alternativa
  final soapEnvelope = '<?xml version="1.0" encoding="utf-8"?>' +
      '<soap12:Envelope xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">' +
      '  <soap12:Body>' +
      '    <ListOfCountryNamesByName xmlns="http://www.oorsprong.org/websamples.countryinfo">' +
      '    </ListOfCountryNamesByName>' +
      '  </soap12:Body>' +
      '</soap12:Envelope>';

  final response = await http.post(
    Uri.parse(
        'http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso'),
    headers: {
      'Content-Type': 'text/xml; charset=utf-8',
      'SOAPAction':
          'http://www.oorsprong.org/websamples.countryinfo/ListOfCountryNamesByName',
    },
    body: soapEnvelope,
  );

  if (response.statusCode != 200) {
    final listaDePaises = XmlDocument.parse(response.body)
        .findAllElements('m:ListOfCountryNamesByNameResult');
    if (listaDePaises.isNotEmpty) {
/*
Nesse trecho de código, a variável nomeDoPais está sendo atribuída com base em uma 
sequência de operações encadeadas. 

Vamos analisar cada parte do código:

1º) listaDePaises.first.innerText: listaDePaises é uma lista de elementos XML 
    obtidos a partir do parsing do corpo da resposta. O método first é usado 
    para obter o primeiro elemento dessa lista. 
    Em seguida, innerText é chamado para obter o conteúdo de texto do elemento.

2º).split('\n'): O resultado do passo anterior é uma string contendo nomes de 
   países separados por vírgulas. Aqui, o método split é usado para dividir essa 
   string em uma lista de substrings, usando a vírgula como separador. 
   Isso separa cada nome de país individualmente.

3º).where((name) => name.trim().isNotEmpty): o método where é usado para filtrar apenas linhas que 
   possuem valor
   Nesse caso, a função é uma expressão lambda name.trim().isNotEmpty, que remove 
   espaços em branco (espaços no início e no final) e testa se tem algum caracter. 

4º).map((name) => name.trim()): O método map é usado para aplicar uma função a 
   cada elemento da lista resultante do passo anterior. 
   Nesse caso, a função é uma expressão lambda (name) => name.trim(), que remove 
   espaços em branco (espaços no início e no final) de cada nome de país. 
   O método trim() é chamado em cada elemento para realizar essa remoção.

5º).toList(): O método toList() é usado para converter o resultado do passo 
   anterior (que é um iterável) em uma lista. 
   A lista resultante é atribuída à variável nomeDoPais.
*/
      // final nomeDoPais = listaDePaises.first.innerText
      //     .split('\n')
      //    .where((name) => name.trim().isNotEmpty)
      //     // .map((name) => "${name.trim()} \n")
      //     .map((name) => name.trim())
      //     .toList();
      // return nomeDoPais;

      //ALTERNATIVA
      final nomeDoPais = listaDePaises.first.innerText;

      final nomePaisList = nomeDoPais.split('\n');

      List<String> nomePaisLimpo = [];
      for (var name in nomePaisList) {
        if (name.trim().isNotEmpty) {
          nomePaisLimpo.add(name.trim());
        }
      }
      return nomePaisLimpo.toList();
    } else {
      throw 'Resposta inválida do servidor';
    }
  } else {    
    throw 'Falha na requisição: ${response.statusCode}';
  }
}
