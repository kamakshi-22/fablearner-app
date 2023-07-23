import 'package:fablearner_app/design/screens/home/load_home_screen.dart';
import 'package:fablearner_app/design/widgets/widgets.dart';
import 'package:fablearner_app/providers/providers.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "Login Screen",
            style: AppTextStyles.displayMedium,
          ),
        ),
        body: Center(
          child: authProvider.isLoading
              ? const AppLoadingIndicator()
              : ElevatedButton(
                  onPressed: () async {
                    await authProvider.fetchAuthToken();
                    String token = authProvider.authToken;
                    String username = authProvider.username;
                    if (!mounted) return;
                    if (token != '' && username != '') {
                      ScaffoldMessenger.of(context).showSnackBar(
                        showSuccessSnackBar("Successfully Logged In"),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => LoadHomeScreen(
                              authToken: token, userDisplayName: username),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        showErrorSnackBar("Please Try Again Later."),
                      );
                    }
                  },
                  child: Text(
                    "Login",
                    style: AppTextStyles.bodyLarge,
                  ),
                ),
        ));
  }
}
