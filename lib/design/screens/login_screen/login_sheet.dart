import 'package:fablearner_app/data/user_preferences.dart';
import 'package:fablearner_app/design/screens/nav_screen/nav_screen.dart';
import 'package:fablearner_app/providers/courses_provider.dart';
import 'package:fablearner_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class LoginBottomSheet extends StatefulWidget {
  const LoginBottomSheet({
    super.key,
  });

  @override
  State<LoginBottomSheet> createState() => _LoginBottomSheetState();
}

class _LoginBottomSheetState extends State<LoginBottomSheet> {
  final formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool isPasswordVisible = false;

  @override
  void initState() {
    super.initState();
    usernameController.addListener(() => setState(() {}));
    passwordController.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: appDefaultPadding, vertical: appDefaultPadding),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Login to Continue",
                style: AppTextStyles.headlineSmall,
              ),
              Gap(
                AppLayout.getHeight(appDefaultSpacing * 0.8),
              ),
              usernameField(),
              Gap(
                AppLayout.getHeight(appDefaultSpacing * 0.4),
              ),
              passwordField(),
              Gap(
                AppLayout.getHeight(appDefaultSpacing),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [loginButton(), forgotPasswordButton()],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextButton forgotPasswordButton() {
    return TextButton(
        onPressed: () {},
        child: Text(
          'Forgot Password?',
          style:
              AppTextStyles.labelSmall.copyWith(color: AppColors.primaryColor),
        ));
  }

  ElevatedButton loginButton() {
    return ElevatedButton(
      onPressed: handleLogin,
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(appCircularBorderRadius),
          ),
          backgroundColor: AppColors.primaryColor),
      child: Text(
        "Login".toUpperCase(),
        style: AppTextStyles.labelLarge.copyWith(
          color: AppColors.backgroundColor,
        ),
      ),
    );
  }

  TextFormField passwordField() {
    return TextFormField(
      controller: passwordController,
      decoration: InputDecoration(
        labelText: 'Password',
        hintText: 'Enter Password',
        suffixIcon: IconButton(
          onPressed: () => setState(() {
            isPasswordVisible = !isPasswordVisible;
          }),
          icon: isPasswordVisible
              ? const Icon(FontAwesomeIcons.eye)
              : const Icon(FontAwesomeIcons.eyeSlash),
        ),
      ),
      obscureText: !isPasswordVisible,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter your password.';
        } else {
          return null;
        }
      },
    );
  }

  TextFormField usernameField() {
    return TextFormField(
      controller: usernameController,
      decoration: InputDecoration(
        labelText: 'Username',
        hintText: 'Enter Username',
        suffixIcon: usernameController.text.isEmpty
            ? Container(
                width: 0,
              )
            : IconButton(
                onPressed: () => usernameController.clear(),
                icon: Icon(
                  FontAwesomeIcons.xmark,
                  size: appIconSize * 0.8,
                ),
              ),
      ),
      textInputAction: TextInputAction.done,
      validator: (value) {
        if (value!.isEmpty) {
          return 'Enter your username.';
        } else {
          return null;
        }
      },
    );
  }

  void handleLogin() async {
    try {
      showLoadingIndicator(context);
      final isValid = formKey.currentState!.validate();
      if (isValid) {
        // Save Username and password variables
        final username = usernameController.text;
        final password = passwordController.text;

        // Proceed if widget is not disposed
        if (mounted) {
          // Fetch providers needed
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          final coursesProvider =
              Provider.of<CoursesProvider>(context, listen: false);

          // Get user details
          await userProvider.fetchUser(username, password);

          // Use the user token to fetch course model
          await coursesProvider.fetchCourseModel(userProvider.user.token);

          // Save the user details to UserPreferences
          UserPreferences.setUserToken(userProvider.user.token);
          UserPreferences.setUserDisplayName(userProvider.user.userDisplayName);
          UserPreferences.setUserEmail(userProvider.user.userEmail);

          if (mounted) //if widget disposed don't navigate
          {
            Navigator.of(context).pop();
            Navigator.push(
              context,
              PageTransition(
                child: NavScreen(),
                type: PageTransitionType.fade,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        }
      }
    } catch (e) {
      Navigator.of(context).pop();
      showErrorToast("Incorrect username or password. Please try again.");
      rethrow;
    }
  }
}
