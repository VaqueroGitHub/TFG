import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/providers/email_pass_form_provider.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/repository/auth_repository.dart';
import 'package:flutter_application_tfg/services/user_service.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService {
  final storage = FlutterSecureStorage();

  Future<String?> signUpUser(User user) async {
    final resp = await GetIt.I<AuthRepository>().signUpUser(user);

    final Map<String, dynamic> decodedResp = jsonDecode(resp.body);

    if (decodedResp.containsKey('idToken')) {
      //Registro realizado con exito
      //Guardar informacion usuario con su uid auto generado
      GetIt.I<UserService>().updateUserData(user, true);
      return null;
    } else {
      if (decodedResp.containsKey('error')) {
        if (decodedResp['error']['message'] == 'EMAIL_EXISTS') {
          return 'Email ya existente.';
        } else {
          return 'Error de conexion';
        }
      }
      return 'Error de conexion';
    }
  }

  Future<String?> signInUser(
      String email, String password, BuildContext context) async {
    final Map<String, dynamic> decodedResp =
        await GetIt.instance<AuthRepository>().singInUserInfo(email, password);

    if (decodedResp.containsKey('idToken')) {
      var userInfo =
          await GetIt.I<UserService>().getUserData(decodedResp['localId']);
      if (userInfo == null) return 'Información del Usuario no encontrada';

      //Token e info relativa a usuario hay que guardarlo en lugar seguro para el uso de la app
      await storage.write(key: 'token', value: decodedResp['idToken']);
      await storage.write(key: 'userId', value: decodedResp['localId']);

      return null;
    } else {
      if (decodedResp.containsKey('error')) {
        if (decodedResp['error']['message'] == 'EMAIL_NOT_FOUND') {
          return 'Usuario no registrado';
        } else if (decodedResp['error']['message'] == 'INVALID_PASSWORD') {
          return 'Contraseña incorrecta';
        } else {
          return 'Error de conexion';
        }
      }
      return 'Error de conexion';
    }
  }

  Future<String?> deleteAccount(User user) async {
    final Map<String, dynamic> decodedResp =
        await GetIt.instance<AuthRepository>()
            .singInUserInfo(user.email, user.password);

    final authData = {'idToken': decodedResp['idToken']};
    final resp = await GetIt.I<AuthRepository>().deleteAccount(authData);

    if (resp.body.contains("error")) return resp.body;
    GetIt.I<UserService>().updateUserData(user, false);
    return null;
  }

  Future<String?> changeEmailPassword(
      EmailPassFormProvider emailPassFormProvider,
      UserSessionProvider userSessionProvider) async {
    final resp = await GetIt.I<AuthRepository>().changeEmail(
        emailPassFormProvider, userSessionProvider, await getIdToken());
    final Map<String, dynamic> decodedResp = jsonDecode(resp.body);
    if (decodedResp.containsKey('idToken')) {
      User user = userSessionProvider.user;
      user.email = emailPassFormProvider.email;
      user.password = emailPassFormProvider.password;
      GetIt.I<UserService>().updateUserData(user, true);
      return null;
    } else {
      if (decodedResp.containsKey('error')) {
        if (decodedResp['error']["message"] ==
            'CREDENTIAL_TOO_OLD_LOGIN_AGAIN') {
          return 'Sesion caducada hacer login de nuevo.';
        }
        if (decodedResp['error']["message"] == 'EMAIL_EXISTS') {
          return 'Email introducido ya existente';
        }
        if (decodedResp['error']["message"] == 'TOKEN_EXPIRED') {
          return 'Volver hacer login para aplicar cambios';
        }
        return decodedResp['error']["message"];
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

  Future<bool> isAdmin() async {
    final json = await storage.read(key: 'userInfo');
    User user = User.fromJson(jsonDecode(json!));
    return user.isAdmin;
  }

  Future<String> getUserId() async {
    final userId = await storage.read(key: 'userId');
    return userId!;
  }

  Future<String> getIdToken() async {
    final idToken = await storage.read(key: 'token');
    return idToken!;
  }
}
