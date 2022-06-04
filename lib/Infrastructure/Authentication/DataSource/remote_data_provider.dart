import 'package:http/http.dart' as http;

class AuthDataProvider {
  static const String _baseUrl = "localhost:8080/api/v1/authenticate";
  Future<String> attemptLogin(String email, String password) async {
    final response = await http.post(Uri.parse(_baseUrl),
        body: {"email": email, "password": password});

    if (response.statusCode == 200){
      return response.body;}
    else{
      throw Exception("Authentication Failed");}
  }
}
