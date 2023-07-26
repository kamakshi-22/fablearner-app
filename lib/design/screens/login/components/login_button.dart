import 'package:fablearner_app/design/screens/home/home_screen.dart';
import 'package:fablearner_app/providers/courses_provider.dart';
import 'package:fablearner_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fablearner_app/design/widgets/widgets.dart';
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
  void _handleLoginButtonPressed() async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      await userProvider.fetchUser();
      if (mounted) { //if widget disposed don't proceed
        final coursesProvider =
            Provider.of<CoursesProvider>(context, listen: false);
        await coursesProvider.fetchCourseModel(userProvider.user.token);
        if (mounted) //if widget disposed don't navigate
        {Navigator.push(context, MaterialPageRoute(builder: (context) {
          return HomeScreen();
        }));}
      }
    } catch (e) {
      showErrorToast("Something went wrong.");
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final coursesProvider =
        Provider.of<CoursesProvider>(context, listen: false);
    return userProvider.isLoading
        ? const AppLoadingIndicator()
        : ElevatedButton(
            onPressed: _handleLoginButtonPressed,
            child: Text(
              "Login",
              style: AppTextStyles.bodyLarge,
            ),
          );
  }
}
