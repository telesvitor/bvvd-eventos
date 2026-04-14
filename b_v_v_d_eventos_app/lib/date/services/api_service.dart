import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  // Use 10.0.2.2 para emulador Android ou localhost para iOS/Web
  static const String baseUrl = "http://localhost:8080";

  // BUSCAR TODOS OS CLIENTES (GET)
  // Mudei o nome de listarEventos para listarClientes para bater com o main.dart
  Future<List<dynamic>> listarClientes() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/clientes'));

      if (response.statusCode == 200) {
        // O utf8.decode garante que acentos funcionem (ex: São Paulo)
        return json.decode(utf8.decode(response.bodyBytes));
      } else {
        throw Exception('Erro ao buscar clientes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Erro de conexão com o servidor: $e');
    }
  }

  // CRIAR NOVO CLIENTE (POST)
  Future<void> criarCliente(Map<String, dynamic> dados) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/clientes'),
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(dados),
      );

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Erro ao criar cliente: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Falha ao enviar dados: $e');
    }
  }
}