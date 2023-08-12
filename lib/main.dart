import 'package:fablearner_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'package:fablearner_app/data/user_preferences.dart';
import 'package:fablearner_app/design/screens/login/login_screen.dart';
import 'package:fablearner_app/design/screens/nav/nav_screen.dart';
import 'package:fablearner_app/design/widgets/widgets.dart';
import 'package:fablearner_app/providers/courses_provider.dart';
import 'package:fablearner_app/providers/drawer_state_provider.dart';
import 'package:fablearner_app/providers/finish_lesson_provider.dart';
import 'package:fablearner_app/providers/lesson_provider.dart';
import 'package:fablearner_app/providers/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load();
  await UserPreferences.init();
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    List<SingleChildWidget> appProviders = [
      ChangeNotifierProvider(create: (_) => UserProvider()),
      ChangeNotifierProvider(create: (_) => CoursesProvider()),
      ChangeNotifierProvider(create: (_) => LessonProvider()),
      ChangeNotifierProvider(create: (_) => FinishLessonProvider()),
      ChangeNotifierProvider(create: (_) => DrawerStateProvider()),
    ];
    return MultiProvider(
      providers: appProviders,
      child: const MaterialApp(
        title: 'Fablearner Reading App',
        debugShowCheckedModeBanner: false,
        home: CoursesFetcherWidget(),
      ),
    );
  }
}

class CoursesFetcherWidget extends StatelessWidget {
  const CoursesFetcherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final String? userToken = UserPreferences.getUserToken();

    if (userToken != null) {
      return FutureBuilder(
        future: Provider.of<CoursesProvider>(context, listen: false)
            .fetchCourseModel(userToken),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.none) {
            return const ErrorScreen(text: 'No connection found.');
          } else if (snapshot.connectionState == ConnectionState.active ||
              snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: LoadingScreen());
          } else if (snapshot.hasError) {
            printIfDebug(snapshot.error);
            return LoginScreen();
          } else {
            return NavScreen();
          }
        },
      );
    } else {
      return LoginScreen();
    }
  }
}





/* class MainApp extends StatefulWidget {
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
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: appProviders,
      child: MaterialApp(
        title: 'Fablearner Reading App',
        debugShowCheckedModeBanner: false,
        home: FutureBuilder<bool>(
          future: _userProvider
              .validateAuthToken(UserPreferences.getUserToken() ?? ""),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const LoadingScreen();
              default:
                if (snapshot.hasError || !(snapshot.data ?? false)) {
                  return const LoginScreen();
                } else {
                  return FutureBuilder(
                    future: Provider.of<CoursesProvider>(context, listen: false)
                        .fetchCourseModel(UserPreferences.getUserToken()),
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return const ErrorScreen(
                            text: 'No connection found.',
                          );
                        case ConnectionState.active:
                        case ConnectionState.waiting:
                          return const Center(child: LoadingScreen());
                        case ConnectionState.done:
                          if (snapshot.hasError) {
                            return ErrorScreen(text: snapshot.error.toString());
                          } else {
                            return const NavScreen();
                          }
                        default:
                          return const ErrorScreen(
                              text: 'Unknown connection state');
                      }
                    },
                  );
                }
            }
          },
        ),
      ),
    );
  }
} */

/*

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
        return; // User is logged in with a valid token, show home screen(Nav Screen)
      }
    }
    // Token is invalid or not available, show login screen
    if (mounted) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    }
  }
  
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
          )
*/