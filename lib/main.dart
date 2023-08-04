import 'package:fablearner_app/data/user_preferences.dart';
import 'package:fablearner_app/design/screens/login/login_screen.dart';
import 'package:fablearner_app/design/screens/nav/nav_screen.dart';
import 'package:fablearner_app/providers/courses_provider.dart';
import 'package:fablearner_app/providers/drawer_state_provider.dart';
import 'package:fablearner_app/providers/finish_lesson_provider.dart';
import 'package:fablearner_app/providers/lesson_provider.dart';
import 'package:fablearner_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Load the environment variables from the .env file
  await dotenv.load();
  await UserPreferences.init();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final UserProvider _userProvider = UserProvider();
  List<SingleChildWidget> appProviders = [
    ChangeNotifierProvider(create: (_) => UserProvider()),
    ChangeNotifierProvider(create: (_) => CoursesProvider()),
    ChangeNotifierProvider(create: (_) => LessonProvider()),
    ChangeNotifierProvider(create: (_) => FinishLessonProvider()),
    ChangeNotifierProvider(create: (_) => DrawerStateProvider()),
  ];

  @override
  void initState() {
    super.initState();
    checkTokenValidity();
  }

  Future<void> checkTokenValidity() async {
    final token = UserPreferences.getUserToken();
    if (token != null && token.isNotEmpty) {
      bool isValidToken = await _userProvider.validateAuthToken(token);
      if (isValidToken) {
        // User is logged in with a valid token, show home screen(Nav Screen)
        return;
      }
    }
    // Token is invalid or not available, show login screen
    if (mounted) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: MaterialApp(
          title: 'Fablearner Reading App',
          debugShowCheckedModeBanner: false,
          home: FutureBuilder<bool>(
            future: _userProvider.validateAuthToken(UserPreferences
                    .getUserToken() ??
                ""), //validateAuthToken method receives an empty string as a token argument instead of a null value if the token is not available
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                // token invalid
                if (snapshot.hasError || !snapshot.data!) {
                  return LoginScreen();
                } else {
                  // User is logged in with a valid token
                  return FutureBuilder(
                    future: Provider.of<CoursesProvider>(context, listen: false)
                        .fetchCourseModel(UserPreferences.getUserToken()),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          // Future has not been triggered yet
                          return const Center(
                              child:
                                  Text('Press button to start. or Loading..'));
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          // Future is still running
                          return const Center(
                              child: CircularProgressIndicator());
                        case ConnectionState.done:
                          // Future has completed, and you can handle the result accordingly
                          if (snapshot.hasError) {
                            // Handle error
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else {
                            // Handle successful result

                            return NavScreen();
                          }
                        default:
                          return Center(
                              child: Text('Unknown connection state'));
                      }
                    },
                  );
                }
              }
            },
          )),
    );
  }
}
