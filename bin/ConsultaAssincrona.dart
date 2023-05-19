import 'dart:convert';
import 'package:intl/intl.dart' as intl;
import 'package:http/http.dart' as http; 

Future<void> main() async {
  var url = Uri.parse('https://api.github.com/users/celsosaraujo');
  final headers = {'Authorization': 'Bearer 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'};
  var response = await http.get(url,headers: headers);
  //print(response.body);
  var data = jsonDecode(response.body);
/*
  final dataCriacao = DateTime.parse(data["created_at"]);  
  final dataAtualizacao = DateTime.parse(data["updated_at"]);  
  final formatoSaida = intl.DateFormat("dd/MM/yyyy HH:mm");
*/
  print("Usuário: ${data["login"]}");
  //print("Data de Criação: ${formatoSaida.format(dataCriacao)}");   
  print("Data de Criação: ${formataData(data["created_at"], formato: "dd/MM/yyyy")}");   
  //print("Último Acesso: ${formatoSaida.format(dataAtualizacao)}");     
  print("Último Acesso: ${formataData(data["updated_at"])}");     
  print("Endpoint Repositório: ${data["repos_url"]}");

  url      = Uri.parse(data["repos_url"]);
  response = await http.get(url, headers: headers);
  data = jsonDecode(response.body);

  print("PROJETOS:");
  for (var item in data) {

    print("\tProjeto: ${item["name"]} <-> URL: ${item["clone_url"]}");
    
  }

}

String formataData(String data,{ String formato = "dd/MM/yyyy HH:mm"}){
 
    final dataConversao = DateTime.parse(data); 
    final formatoSaida = intl.DateFormat(formato); 
    return formatoSaida.format(dataConversao);

}