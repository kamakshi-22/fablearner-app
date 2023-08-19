import 'package:fablearner_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:fablearner_app/data/user_preferences.dart';
import 'package:fablearner_app/design/screens/login_screen/login_screen.dart';
import 'package:fablearner_app/design/screens/nav_screen/nav_screen.dart';
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
  runApp(const MainApp());
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
        home: BuildEntryScreen(),
      ),
    );
  }
}

class BuildEntryScreen extends StatelessWidget {
  const BuildEntryScreen({super.key});

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
            return const LoginScreen();
          } else {
            return const NavScreen();
          }
        },
      );
    } else {
      return const LoginScreen();
    }
  }
}