import 'dart:convert';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  //Singleton class
  static final AuthService _authService = AuthService._internal();

  factory AuthService() {
    return _authService;
  }
  AuthService._internal();

  final _baseUrl = 'identitytoolkit.googleapis.com';
  final _apiKey = 'AIzaSyAvGNXDQ5fEkPmxsD4j9qbyM1JO5dX5lcU';

  final storage = new FlutterSecureStorage();

  Future<String?> signUpUser(User user) async {
    final authData = {
      'email': user.email,
      'password': user.password,
      'returnSecureToken': true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _apiKey});
    final resp = await http.post(url, body: jsonEncode(authData));

    final Map<String, dynamic> decodedResp = jsonDecode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      //Registro realizado con exito
      //Guardar informacion usuario con su uid auto generado
      // DatabaseService(uuid: decodedResp['localId']).updateUserData(user);
      return null;
    } else {
      if (decodedResp.containsKey('error')) {
        if (decodedResp['error']['message'] == 'EMAIL_EXISTS')
          return 'Email ya existente.';
        else
          return 'Error de conexion';
      }
      return 'Error de conexion';
    }
  }

  Future<String?> signInUser(String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _apiKey});
    final resp = await http.post(url, body: jsonEncode(authData));

    final Map<String, dynamic> decodedResp = jsonDecode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      //Token hay que guardarlo en lugar seguro
      await storage.write(key: 'token', value: decodedResp['idToken']);

      // bool isAdmin =await DatabaseService(uuid: decodedResp['localId']).getUserData();
      // await storage.write(key: 'isAdmin', value: isAdmin.toString());
      return null;
    } else {
      if (decodedResp.containsKey('error')) {
        if (decodedResp['error']['message'] == 'EMAIL_NOT_FOUND')
          return 'Usuario no registrado';
        else if (decodedResp['error']['message'] == 'INVALID_PASSWORD')
          return 'Contraseña incorrecta';
        else
          return 'Error de conexion';
      }
      return 'Error de conexion';
    }
  }

  Future logout() async {
    await storage.delete(key: 'token');
  }

  Future<String> isAuth() async {
    return await storage.read(key: 'token') ?? '';
  }

  // Future<String> isAdmin() async {
  //   return await storage.read(key: 'isAdmin') ?? 'false';
  // }
}