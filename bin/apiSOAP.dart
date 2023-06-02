import 'package:http/http.dart' as http;
import 'package:xml/xml.dart';

void main() {
  retornaNomesPaises().then((nomePais) {
    print(nomePais);
  }).catchError((error) {
    print('Erro: $error');
  });
}

Future<List<String>> retornaNomesPaises() async {
  //  são tres aspas simples
  final soapEnvelope = '''<?xml version="1.0" encoding="utf-8"?>
      <soap12:Envelope xmlns:soap12="http://www.w3.org/2003/05/soap-envelope">
        <soap12:Body>
          <ListOfCountryNamesByName xmlns="http://www.oorsprong.org/websamples.countryinfo">
          </ListOfCountryNamesByName>
        </soap12:Body>
      </soap12:Envelope>''';

  final response = await http.post(
    Uri.parse(
        'http://webservices.oorsprong.org/websamples.countryinfo/CountryInfoService.wso'),
    headers: {
      'Content-Type': 'text/xml; charset=utf-8',
      'SOAPAction': 'http://www.oorsprong.org/websamples.countryinfo/ListOfCountryNamesByName',
    },
    body: soapEnvelope,
  );

  if (response.statusCode == 200) {
    final listaDePaises = XmlDocument.parse(response.body).findAllElements('m:ListOfCountryNamesByNameResult');
    if (listaDePaises.isNotEmpty) {
      final nomeDoPais = listaDePaises.first.innerText
          .split('\n')
          .map((name) => name.trim())
          .toList();
      return nomeDoPais;
    } else {
      throw 'Resposta inválida do servidor';
    }
  } else {
    throw 'Falha na requisição: ${response.statusCode}';
  }
}