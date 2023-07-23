import 'package:fablearner_app/design/screens/login/login_screen.dart';
import 'package:fablearner_app/providers/providers.dart';
import 'package:fablearner_app/utils/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  // Load the environment variables from the .env file
  await dotenv.load();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => DataProvider()),
      ],
      child: MaterialApp(
        title: 'Fablearner Reading App',
        debugShowCheckedModeBanner: false,
        home: LoginScreen(),
      ),
    );
  }
}
