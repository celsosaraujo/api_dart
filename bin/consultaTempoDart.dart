import 'package:intl/intl.dart' as intl;
import 'package:dio/dio.dart';

class Tempo {
  String tempCelsius;
  String dataHora;
  String cidade;
  String urlIcon;

  Tempo(this.tempCelsius, this.dataHora, this.cidade, this.urlIcon);

  static String timestampToData(int timestamp) {
    DateTime data = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    final formatoSaida = intl.DateFormat("dd/MM/yyyy HH:mm");
    DateTime dataLocal = data.toLocal();
    return formatoSaida.format(dataLocal);
  }

  static Future<Tempo> consultaTempo() async {
    final apiKey = '684092e38c36b56bb340fdd83d8c6bd9';
    final latitude = '-22.2138900';
    final longitude = '-49.9458300';
    final uri = Uri(
      scheme: 'https',
      host: 'api.openweathermap.org',
      path: '/data/2.5/weather',
      queryParameters: {
        'lat': latitude,
        'lon': longitude,
        'lang': 'pt_br',
        'appid': apiKey,
        'units': 'metric',
      },
    );

    final dio = Dio();
    final response = await dio.get(uri.toString());
    if (response.statusCode == 200) {
      return Tempo(
          response.data["main"]["temp"].toString(),
          timestampToData(response.data["dt"]),
          response.data["name"],
          "https://openweathermap.org/img/wn/${response.data["weather"][0]["icon"]}@2x.png");
    } else {
      print('Erro ao fazer requisição: ${response.statusCode}');
      throw Exception('Erro ao fazer requisição');
    }
  }
}

void main() async {
  var tempo = await Tempo.consultaTempo();

  print("Temperatura de ${tempo.tempCelsius} °C "
      "em ${tempo.cidade} "
      "no dia ${tempo.dataHora} "
      "icone: ${tempo.urlIcon}");
}
