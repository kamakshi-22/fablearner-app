
import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/providers/lesson_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:html/parser.dart' show parse;
import 'package:fablearner_app/design/screens/video_screen/video_screen.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:provider/provider.dart';

class LessonPlayButton extends StatelessWidget {
  final LessonModel lesson;
  const LessonPlayButton({
    super.key, required this.lesson,
  });


  @override
  Widget build(BuildContext context) {
    final lessonProvider = Provider.of<LessonProvider>(context);
    final lesson = lessonProvider.lessonModel;
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
}
