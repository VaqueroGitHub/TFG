import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_tfg/providers/answer_form_provider.dart';
import 'package:flutter_application_tfg/providers/edit_user_provider.dart';
import 'package:flutter_application_tfg/providers/email_pass_form_provider.dart';
import 'package:flutter_application_tfg/providers/forum_list_provider.dart';
import 'package:flutter_application_tfg/providers/group_details_provider.dart';
import 'package:flutter_application_tfg/providers/group_form_provider.dart';
import 'package:flutter_application_tfg/providers/group_list_provider.dart';
import 'package:flutter_application_tfg/providers/message_form_provider.dart';
import 'package:flutter_application_tfg/providers/post_form_provider.dart';
import 'package:flutter_application_tfg/providers/post_main_provider.dart';
import 'package:flutter_application_tfg/providers/service_details_provider.dart';
import 'package:flutter_application_tfg/providers/service_form_provider.dart';
import 'package:flutter_application_tfg/providers/service_list_provider.dart';
import 'package:flutter_application_tfg/providers/ui_provider.dart';
import 'package:flutter_application_tfg/providers/user_login_provider.dart';
import 'package:flutter_application_tfg/providers/user_register_provider.dart';
import 'package:flutter_application_tfg/providers/user_session_provider.dart';
import 'package:flutter_application_tfg/repository/answer_repository.dart';
import 'package:flutter_application_tfg/repository/auth_repository.dart';
import 'package:flutter_application_tfg/repository/forum_repository.dart';
import 'package:flutter_application_tfg/repository/group_repository.dart';
import 'package:flutter_application_tfg/repository/message_group_repository.dart';
import 'package:flutter_application_tfg/repository/message_service_repository.dart';
import 'package:flutter_application_tfg/repository/post_repository.dart';
import 'package:flutter_application_tfg/repository/service_repository.dart';
import 'package:flutter_application_tfg/repository/user_repository.dart';
import 'package:flutter_application_tfg/screens/admin/admin_home_page.dart';
import 'package:flutter_application_tfg/screens/group/members_group_screen.dart';
import 'package:flutter_application_tfg/screens/group/new_group_message_screen.dart';
import 'package:flutter_application_tfg/screens/home_page.dart';
import 'package:flutter_application_tfg/screens/login/check_auth.dart';
import 'package:flutter_application_tfg/screens/profile/see_profile_screen.dart';
import 'package:flutter_application_tfg/screens/screens.dart';
import 'package:flutter_application_tfg/screens/service/all_services_screen.dart';
import 'package:flutter_application_tfg/screens/service/new_service_message_screen.dart';
import 'package:flutter_application_tfg/screens/service/new_service_screen.dart';
import 'package:flutter_application_tfg/screens/service/service_details_screen.dart';
import 'package:flutter_application_tfg/screens/service/service_main_page.dart';
import 'package:flutter_application_tfg/services/answer_database_service.dart';
import 'package:flutter_application_tfg/services/auth_service.dart';
import 'package:flutter_application_tfg/services/forum_service.dart';
import 'package:flutter_application_tfg/services/group_service.dart';
import 'package:flutter_application_tfg/services/message_group_service.dart';
import 'package:flutter_application_tfg/services/message_service_service.dart';
import 'package:flutter_application_tfg/services/post_service.dart';
import 'package:flutter_application_tfg/services/service_service.dart';
import 'package:flutter_application_tfg/services/user_service.dart';
import 'package:flutter_application_tfg/styles/tfg_theme.dart';
import 'package:get_it/get_it.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetIt locator = GetIt.instance;
  locator.registerFactory<AuthRepository>(() => AuthRepository());
  locator.registerFactory<AuthService>(() => AuthService());
  locator.registerFactory<UserService>(() => UserService());
  locator.registerFactory<UserRepository>(() => UserRepository());
  locator.registerFactory<GroupService>(() => GroupService());
  locator.registerFactory<GroupRepository>(() => GroupRepository());
  locator.registerFactory<ForumRepository>(() => ForumRepository());
  locator.registerFactory<ForumService>(() => ForumService());
  locator.registerFactory<PostService>(() => PostService());
  locator.registerFactory<PostRepository>(() => PostRepository());
  locator.registerFactory<MessageServiceService>(() => MessageServiceService());
  locator.registerFactory<MessageServiceRepository>(
      () => MessageServiceRepository());
  locator.registerFactory<MessageGroupService>(() => MessageGroupService());
  locator
      .registerFactory<MessageGroupRepository>(() => MessageGroupRepository());
  locator.registerFactory<AnswerService>(() => AnswerService());
  locator.registerFactory<AnswerRepository>(() => AnswerRepository());
  locator.registerFactory<ServiceRepository>(() => ServiceRepository());

  locator.registerFactory<ServiceService>(() => ServiceService());

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
        ChangeNotifierProvider(create: (_) => MessageFormProvider()),
        ChangeNotifierProvider(create: (_) => GroupFormProvider()),
        ChangeNotifierProvider(create: (_) => ServiceListProvider()),
        ChangeNotifierProvider(create: (_) => ServiceFormProvider()),
        ChangeNotifierProvider(create: (_) => EditUserProvider()),
        ChangeNotifierProvider(create: (_) => EmailPassFormProvider()),
        ChangeNotifierProvider(create: (_) => GroupDetailsProvider()),
        ChangeNotifierProvider(create: (_) => ServiceDetailsProvider()),
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
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case 'aboutProfile':
            return PageTransition(
                type: PageTransitionType.scale,
                alignment: Alignment.bottomCenter,
                child: AboutProfilePage());
          default:
            return null;
        }
      },
      routes: {
        'home': (_) => HomeScreen(),
        'homePage': (_) => HomePage(),
        'register': (_) => RegisterScreen(),
        'logIn': (_) => LogInScreen(),
        'checkAuth': (_) => CheckAuthScreen(),
        'profile': (_) => ProfileScreen(),
        'aboutProfile': (_) => AboutProfilePage(),
        'seeProfile': (_) => SeeProfilePage(),
        'editProfile': (_) => EditProfilePage(),
        'manageUsers': (_) => ManageUsersScreen(),
        'adminHomePage': (_) => AdminHomePage(),
        'groupsMainPage': (_) => GroupsMainPage(),
        'newGroupPage': (_) => NewGroupPage(),
        'manageGroups': (_) => ManageGroupsScreen(),
        'editGroup': (_) => EditGroupPage(),
        'newGroupMessage': (_) => NewGroupMessagePage(),
        'forumMainPage': (_) => ForumMainPage(),
        'subforumMainPage': (_) => SubforumMainPage(),
        'newSubforumPage': (_) => NewSubforumPage(),
        'newPostPage': (_) => NewPostPage(),
        'postMainPage': (_) => PostMainPage(),
        'newAnswerPage': (_) => NewAnswerPage(),
        'managePosts': (_) => ManagePostsScreen(),
        'groupDetails': (_) => GroupDetailsScreen(),
        'allGroupScreen': (_) => AllGroupsPage(),
        'servicesMainPage': (_) => ServiceMainPage(),
        'allServiceScreen': (_) => AllServicesPage(),
        'serviceDetails': (_) => ServiceDetailsScreen(),
        'newServicePage': (_) => NewServicePage(),
        'newServiceMessage': (_) => NewServiceMessagePage(),
        'membersScreen': (_) => MembersGroupScreen(),
      },
      theme: tfgTheme.copyWith(
          appBarTheme: const AppBarTheme(color: Colors.transparent)),
    );
  }
}
