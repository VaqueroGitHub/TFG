import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/services/user_database_service.dart';
import 'package:http/http.dart' as http;
import 'dart:ffi';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

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
      "email": user.email,
      "password": user.password,
      "returnSecureToken": true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _apiKey});
    final resp = await http.post(url, body: jsonEncode(authData));

    final Map<String, dynamic> decodedResp = jsonDecode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      //Registro realizado con exito
      //Guardar informacion usuario con su uid auto generado
      UserDatabaseService(uuid: decodedResp['localId']).updateUserData(user);
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

  Future<String?> signInUser(
      String email, String password, BuildContext context) async {
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
      var userInfo =
          await UserDatabaseService(uuid: decodedResp['localId']).getUserData();
      if (userInfo == null) return 'no user info found';

      //Token e info relativa a usuario hay que guardarlo en lugar seguro para el uso de la app
      await storage.write(key: 'token', value: decodedResp['idToken']);
      await storage.write(key: 'userId', value: decodedResp['localId']);
      await storage.write(key: 'userInfo', value: jsonEncode(userInfo));

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

  Future<String?> deleteAccount() async {
    final authData = {'idToken': await storage.read(key: 'token')};

    final url = Uri.https(_baseUrl, '/v1/accounts:delete', {'key': _apiKey});
    final resp = await http.post(url, body: jsonEncode(authData));
    if (resp.body.contains("error")) return resp.body;
    final userId = await storage.read(key: 'userId');
    UserDatabaseService(uuid: userId!).deleteUser();
    return null;
  }

  Future logout() async {
    await storage.delete(key: 'token');
  }

  Future<String> isAuth() async {
    return await storage.read(key: 'token') ?? '';
  }

  Future<bool> isAdmin() async {
    final json = await storage.read(key: 'userInfo');
    User user = User.fromJson(jsonDecode(json!));
    return user.isAdmin;
  }

  Future<User> getUser() async {
    final json = await storage.read(key: 'userInfo');
    return User.fromJson(jsonDecode(json!));
  }

  Future<String> getUserId() async {
    final userId = await storage.read(key: 'userId');
    return userId!;
  }
}
