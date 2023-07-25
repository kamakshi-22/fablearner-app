import 'package:fablearner_app/design/screens/home/home_screen.dart';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:flutter/material.dart';
import 'package:fablearner_app/design/widgets/widgets.dart';
import 'package:fablearner_app/providers/providers.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:provider/provider.dart';

class LoginButton extends StatefulWidget {
  const LoginButton({
    super.key,
  });

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final serviceProvider = Provider.of<ServiceProvider>(context);
    return authProvider.isLoading
        ? const AppLoadingIndicator()
        : ElevatedButton(
            onPressed: () {
              try {
                authProvider.fetchAuthToken().then((value) {
                  userProvider.fetchUserData(value);
                  printIfDebug(userProvider.user.userEmail);

                  if (mounted) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return buildHomeScreen(serviceProvider, userProvider);
                    }));
                  }
                });
              } catch (e) {
                showErrorToast("Please Try Again Later.");

                throw Exception(e);
              }
            },
            child: Text(
              "Login",
              style: AppTextStyles.bodyLarge,
            ),
          );
  }

  FutureBuilder<List<CourseModel>> buildHomeScreen(
      ServiceProvider serviceProvider, UserProvider userProvider) {
    return FutureBuilder(
      future: serviceProvider.fetchCoursesData(userProvider.user.token),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const ErrorScreen(text: "No Connection. Please try again.");
          case ConnectionState.active:
          case ConnectionState.waiting:
            return const LoadingScreen();
          case ConnectionState.done:
            final courses = snapshot.data as List<CourseModel>;
            if (snapshot.hasError) {
              printIfDebug(snapshot.error);
              return const ErrorScreen(
                  text: "Encountered error. Please try again.");
            } else {
              Future.delayed(Duration.zero, () {
                Provider.of<CoursesProvider>(context, listen: false)
                    .updateCoursesModel(courses);
              });
              return HomeScreen();
            }

          default:
            return const ErrorScreen(text: 'Unknown connection state');
        }
      },
    );
  }
}

class NewScreen extends StatelessWidget {
  const NewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
