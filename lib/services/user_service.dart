import 'package:flutter_application_tfg/models/user.dart';
import 'package:flutter_application_tfg/repository/user_repository.dart';
import 'package:get_it/get_it.dart';

class UserService {
  UserService();

  Future<User?> getUserData(String uuid) async {
    final resp = await GetIt.I<UserRepository>().getUserData(uuid);
    Map<dynamic, dynamic> data = resp.data() as Map<dynamic, dynamic>;
    if (data == null) return null;
    User user = User(
        nick: data["nick"],
        fullName: data["name"],
        email: data["email"],
        password: data["password"],
        isAdmin: data["isAdmin"],
        bio: data["bio"],
        id: resp.id,
        url: data["url"]);

    return user;
  }

  Future updateUserData(User user, bool active) async {
    if (user.isAdmin) {
      return await GetIt.I<UserRepository>().updateUser({
        'name': user.fullName,
        'email': user.email,
        'password': user.password,
        'nick': user.nick,
        'isAdmin': true,
        "bio": user.bio,
        "url": user.url,
        "active": active
      }, user.id!);
    } else {
      return await GetIt.I<UserRepository>().updateUser({
        'name': user.fullName,
        'email': user.email,
        'password': user.password,
        'nick': user.nick,
        'isAdmin': false,
        "bio": user.bio,
        "url": user.url,
        "active": active
      }, user.id!);
    }
  }

  Future<List<User>> getAllUsersAdmin() async {
    return await GetIt.I<UserRepository>().getAllUsersAdmin();
  }

  Future deleteUser(String userId) async {
    //Borrar grupos
    // GetIt.I<GroupRepository>();
    //Borrar posts
    // GetIt.I<PostRepository>();
    //Borrar servicios
    // GetIt.I<ServiceRepository>();
    //Dar de baja usuario
    await GetIt.I<UserRepository>().delete(userId);
  }
}
