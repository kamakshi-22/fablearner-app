import 'package:fablearner_app/design/screens/lesson/components/lesson_details.dart';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/providers/courses_provider.dart';
import 'package:fablearner_app/providers/lesson_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:html/parser.dart' show parse;

import 'package:fablearner_app/design/screens/video/video_screen.dart';
import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/utils/layout.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:provider/provider.dart';

class LessonScreen extends StatelessWidget {
  final List<Item> lessonItems;
  const LessonScreen({
    super.key,
    required this.lessonItems,
  });

  @override
  Widget build(BuildContext context) {
    final lessonProvider = Provider.of<LessonProvider>(context);
    final courseProvider = Provider.of<CoursesProvider>(context);
    final lesson = lessonProvider.lessonModel;
    final courseId = lesson.assigned.course.id;
    final course = courseProvider.coursesModel
        .where((course) => course.id.toString() == courseId)
        .first;
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
                    videoHolder(lesson, course),
                    playButton(context, lesson),
                    LessonDetails(
                      lesson: lesson,
                      lessonItems: lessonItems,
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

  Hero videoHolder(LessonModel lesson, CourseModel course) {
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

  Positioned playButton(BuildContext context, LessonModel lesson) {
    return Positioned(
      top: AppLayout.getScreenHeight() * 0.2,
      left: AppLayout.getScreenWidth() * 0.2,
      right: AppLayout.getScreenWidth() * 0.2,
      child: IconButton(
        onPressed: () {
          String htmlString = lesson.content;
          String? video;
          try {
            final htmlWithoutComments =
                htmlString.replaceAll(RegExp(r"<!--.*?-->"), "");
            final document = parse(htmlWithoutComments);
            video = document.querySelector("video")!.text;
            printIfDebug(video);
          } catch (e) {
            printIfDebug("error: $e");
            showErrorToast("No Video Found.");
          }

          if (video != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return VideoScreen(
                    videoUrl: video!,
                    lesson: lesson,
                  );
                },
              ),
            );
          }
        },
        icon: Icon(
          FontAwesomeIcons.circlePlay,
          size: 80,
          color: AppColors.successColor,
        ),
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
