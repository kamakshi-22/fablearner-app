import 'package:fablearner_app/design/screens/lesson_screen/lesson_details.dart';
import 'package:fablearner_app/design/screens/lesson_screen/lesson_play_button.dart';
import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/providers/courses_provider.dart';
import 'package:fablearner_app/providers/lesson_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:provider/provider.dart';

class LessonScreen extends StatelessWidget {
  final LessonModel lesson;
  const LessonScreen({
    super.key,
    required this.lesson,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: AppColors.backgroundColor,
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: AppLayout.getScreenHeight(),
                child: Stack(
                  children: [
                    videoHolder(context),
                    LessonPlayButton(
                      lesson: lesson,
                    ),
                    LessonDetails(
                      lesson: lesson,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Hero videoHolder(BuildContext context) {
    // final lessonProvider = Provider.of<LessonProvider>(context);
    // final lesson = lessonProvider.lessonModel;
    final courseProvider = Provider.of<CoursesProvider>(context);
    final courseId = lesson.assigned.course.id;
    final course = courseProvider.coursesModel
        .where((course) => course.id.toString() == courseId)
        .first;
    return Hero(
      tag: lesson.assigned.course.id,
      child: Stack(
        children: [
          Container(
            width: AppLayout.getScreenWidth(),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Image.network(
              course.image,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: 500,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            FontAwesomeIcons.arrowLeft,
            color: AppColors.backgroundColor,
          )),
    );
  }
}
