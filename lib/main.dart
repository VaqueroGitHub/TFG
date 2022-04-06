import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/answer_form_provider.dart';
import 'package:flutter_application_tfg/providers/forum_list_provider.dart';
import 'package:flutter_application_tfg/providers/group_list_provider.dart';
import 'package:flutter_application_tfg/providers/post_form_provider.dart';
import 'package:flutter_application_tfg/providers/post_main_provider.dart';
import 'package:flutter_application_tfg/providers/ui_provider.dart';
import 'package:flutter_application_tfg/providers/user_login_provider.dart';
import 'package:flutter_application_tfg/providers/user_register_provider.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/screens/admin/admin_home_page.dart';
import 'package:flutter_application_tfg/screens/login/check_auth.dart';
import 'package:flutter_application_tfg/screens/screens.dart';
import 'package:flutter_application_tfg/screens/service/service_main_page.dart';
import 'package:flutter_application_tfg/styles/tfg_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(AppState());
}

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserLoginProvider()),
        ChangeNotifierProvider(create: (_) => UserRegisterProvider()),
        ChangeNotifierProvider(create: (_) => UserSessionProvider()),
        ChangeNotifierProvider(create: (_) => UiProvider()),
        ChangeNotifierProvider(create: (_) => GroupListProvider()),
        ChangeNotifierProvider(create: (_) => ForumListProvider()),
        ChangeNotifierProvider(create: (_) => PostFormProvider()),
        ChangeNotifierProvider(create: (_) => AnswerFormProvider()),
        ChangeNotifierProvider(create: (_) => PostMainProvider()),
      ],
      child: MyApplication(),
    );
  }
}

class MyApplication extends StatelessWidget {
  const MyApplication({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nombre App',
      initialRoute: 'checkAuth',
      routes: {
        'home': (_) => HomeScreen(),
        'register': (_) => RegisterScreen(),
        'logIn': (_) => LogInScreen(),
        'checkAuth': (_) => CheckAuthScreen(),
        'profile': (_) => ProfileScreen(),
        'aboutProfile': (_) => AboutProfilePage(),
        'editProfile': (_) => EditProfilePage(),
        'manageUsers': (_) => ManageUsersScreen(),
        'adminHomePage': (_) => AdminHomePage(),
        'groupsMainPage': (_) => GroupsMainPage(),
        'newGroupPage': (_) => NewGroupPage(),
        'manageGroups': (_) => ManageGroupsScreen(),
        'editGroup': (_) => EditGroupPage(),
        'forumMainPage': (_) => ForumMainPage(),
        'subforumMainPage': (_) => SubforumMainPage(),
        'newSubforumPage': (_) => NewSubforumPage(),
        'newPostPage': (_) => NewPostPage(),
        'postMainPage': (_) => PostMainPage(),
        'newAnswerPage': (_) => NewAnswerPage(),
        'managePosts': (_) => ManagePostsScreen(),
        'manageSubforums': (_) => ManageSubforumsScreen(),
        'groupDetails': (_) => GroupDetailsScreen(),
        'allGroupScreen': (_) => AllGroupsPage(),
        'serviceMainPage': (_) => ServiceMainPage(),
      },
      theme: tfgTheme.copyWith(
          appBarTheme: const AppBarTheme(color: Colors.transparent)),
    );
  }
}
