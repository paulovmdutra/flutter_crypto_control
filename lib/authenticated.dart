import 'package:shared_preferences/shared_preferences.dart';

class Authenticated {
  List<Map<String, String>> permissions = [];
  String token = 'access_token';

  // Salvar o token localmente
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
    this.token = token;
  }

  // Apagar o token localmente
  Future<void> deleteToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    token = 'access_token';
  }

  // Buscar o token armazenado
  Future<void> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('auth_token');
    if (savedToken != null) {
      token = savedToken;
    }
  }
}
