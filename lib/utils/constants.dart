import 'package:flutter_dotenv/flutter_dotenv.dart';

String appLoginUrl = dotenv.env['LOGIN_URL']!;
String validateTokenUrl = dotenv.env['VALIDATE_TOKEN_URL']!;
String coursesEnrolledUrl = dotenv.env['COURSES_ENROLLED_URL']!;
String lessonDetailsUrl = dotenv.env['LESSON_DETAILS_URL']!;
String lessonFinishedUrl = dotenv.env['LESSON_FINISHED_URL']!;
String meetingsUrl = dotenv.env['MEETINGS_URL']!;
String helpDeskUrl = dotenv.env['HELPDESK_URL']!;