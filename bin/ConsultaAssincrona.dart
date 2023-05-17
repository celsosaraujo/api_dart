import 'dart:convert';
import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http; 

Future<void> main() async {
  final url = Uri.parse('https://api.github.com/users/octocat');
  final response = await http.get(url);
  //print(response.body);
  final data = jsonDecode(response.body);

  final dataCriacao = DateTime.parse(data["created_at"]);  
  final dataAtualizacao = DateTime.parse(data["updated_at"]);  
  final formatoSaida = intl.DateFormat("dd/MM/yyyy HH:mm");

  print("Usuário: ${data["login"]}");
  print("Data de Criação: ${formatoSaida.format(dataCriacao)}");
  print("Último Acesso: ${formatoSaida.format(dataAtualizacao)}");
  //print("Último Acesso: ${data["updated_at"]}");  
  print("Endpoint Repositório: ${data["repos_url"]}");

}