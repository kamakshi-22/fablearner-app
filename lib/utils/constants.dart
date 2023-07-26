import 'package:flutter_dotenv/flutter_dotenv.dart';

/* ---------------------------------------------------------------- */
/*                          Authentications                         */
/* ---------------------------------------------------------------- */
String appLoginUrl = dotenv.env['LOGIN_URL']!;
String appTestUsername1 = dotenv.env['TEST_USERNAME_1']!;
String appTestUserpassword1 = dotenv.env['TEST_PASSWORD_1']!;
String appTestUsername2 = dotenv.env['TEST_USERNAME_2']!;
String appTestUserpassword2 = dotenv.env['TEST_PASSWORD_2']!;
String coursesEnrolledUrl = dotenv.env['COURSES_ENROLLED_URL']!;
String lessonDetailsUrl = dotenv.env['LESSON_DETAILS_URL']!;
String lessonFinishedUrl = dotenv.env['LESSON_FINISHED_URL']!;
/* ---------------------------------------------------------------- */
/*                              Sizing                              */
/* ---------------------------------------------------------------- */
double appDefaultPadding = 24.0;
double appDefaultSpacing = 24.0;
double appCircularBorderRadius = 28.0;
double appProgressIndicatorHeight = 8.0;
double appCourseImageSize = 120;