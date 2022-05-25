import 'dart:convert';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../providers/email_pass_form_provider.dart';
import '../providers/user_session_provider.dart';

class AuthRepository {
  final _baseUrl = 'identitytoolkit.googleapis.com';
  final _apiKey = 'AIzaSyAvGNXDQ5fEkPmxsD4j9qbyM1JO5dX5lcU';

  Future<Response> signUpUser(User user) async {
    final authData = {
      "email": user.email,
      "password": user.password,
      "returnSecureToken": true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:signUp', {'key': _apiKey});
    return await http.post(url, body: jsonEncode(authData));
  }

  Future<Map<String, dynamic>> singInUserInfo(
      String email, String password) async {
    final authData = {
      'email': email,
      'password': password,
      'returnSecureToken': true
    };

    final url = Uri.https(
        _baseUrl, '/v1/accounts:signInWithPassword', {'key': _apiKey});
    final resp = await http.post(url, body: jsonEncode(authData));

    return jsonDecode(resp.body);
  }

  Future<Response> deleteAccount(authData) async {
    final url = Uri.https(_baseUrl, '/v1/accounts:delete', {'key': _apiKey});
    final resp = await http.post(url, body: jsonEncode(authData));
    return resp;
  }

  Future<Response> changeEmail(EmailPassFormProvider emailPassFormProvider,
      UserSessionProvider userSessionProvider, String idToken) async {
    final authData = {
      "idToken": idToken,
      "email": emailPassFormProvider.email,
      "password": emailPassFormProvider.password,
      "returnSecureToken": true
    };

    final url = Uri.https(_baseUrl, '/v1/accounts:update', {'key': _apiKey});
    return await http.post(url, body: jsonEncode(authData));
  }
}
