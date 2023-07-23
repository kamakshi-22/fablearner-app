import 'package:fablearner_app/design/screens/lesson/load_lesson_screen.dart';
import 'package:fablearner_app/design/widgets/progress_indicator.dart';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/providers/auth_provider.dart';
import 'package:fablearner_app/providers/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:html/parser.dart' show parse;

import 'package:fablearner_app/design/screens/video/video_screen.dart';
import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/utils/layout.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:provider/provider.dart';

class LessonScreen extends StatefulWidget {
  final LessonModel lesson;
  final List<Item> lessonItems;
  const LessonScreen(
      {super.key, required this.lesson, required this.lessonItems});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);
    final authProvider = Provider.of<AuthProvider>(context);
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
                    videoHolder(),
                    playButton(context),
                    lessonDetails(context, authProvider, dataProvider),
                    Center(
                      child: dataProvider.isLoading
                          ? const AppLoadingIndicator()
                          : null,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Hero videoHolder() {
    return Hero(
      tag: widget.lesson.assigned.course.id,
      child: Stack(
        children: [
          Container(
            width: AppLayout.getScreenWidth(),
            decoration: const BoxDecoration(
              color: AppColors.primaryColor,
            ),
            child: Image.asset(
              "assets/images/notebook-3D.png",
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

  Positioned playButton(BuildContext context) {
    return Positioned(
      top: AppLayout.getScreenHeight() * 0.2,
      left: AppLayout.getScreenWidth() * 0.2,
      right: AppLayout.getScreenWidth() * 0.2,
      child: IconButton(
        onPressed: () {
          String htmlString = widget.lesson.content;
          String? video;
          try {
            final htmlWithoutComments =
                htmlString.replaceAll(RegExp(r"<!--.*?-->"), "");
            final document = parse(htmlWithoutComments);
            video = document.querySelector("video")!.text;
            printIfDebug(video);
          } catch (e) {
            printIfDebug("error: $e");
            ScaffoldMessenger.of(context).showSnackBar(
              showErrorSnackBar("No Video Found."),
            );
          }

          if (video != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return VideoScreen(
                    videoUrl: video!,
                    lesson: widget.lesson,
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

  Container lessonDetails(BuildContext context, AuthProvider authProvider,
      DataProvider dataProvider) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: AppLayout.getScreenHeight() * 0.4),
      decoration: BoxDecoration(
        color: AppColors.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(appCirclularBorderRadius),
          topRight: Radius.circular(appCirclularBorderRadius),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(appDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.lesson.name,
              style: AppTextStyles.displaySmall,
            ),
            Gap(AppLayout.getHeight(appDefaultSpacing)),
            Row(
              children: [
                const Icon(
                  FontAwesomeIcons.chevronDown,
                  size: 20,
                ),
                Gap(AppLayout.getWidth(8)),
                Text(
                  widget.lesson.assigned.course.title,
                  style: AppTextStyles.labelLarge.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              ],
            ),
            Gap(AppLayout.getHeight(appDefaultSpacing)),
            Text(
              widget.lesson.assigned.course.content,
              style: AppTextStyles.bodyMedium,
            ),
            Gap(AppLayout.getHeight(appDefaultSpacing)),
            markFinished(authProvider, dataProvider),
            if (!widget.lesson.results.status.contains("completed"))
              Text(
                "** This can only be marked once! **",
                style: AppTextStyles.labelSmall
                    .copyWith(color: AppColors.errorColor),
              ),
            const Spacer(),
            nextLesson(context),
          ],
        ),
      ),
    );
  }

  ElevatedButton markFinished(
      AuthProvider authProvider, DataProvider dataProvider) {
    return ElevatedButton(
      onPressed: () async {
        try {
          if (widget.lesson.results.status.contains("completed") ||
              dataProvider.isLoading) {
            return;
          } else {
            final response = await dataProvider.finishLesson(
                widget.lesson.id.toString(), authProvider.authToken);
            if (!mounted) return;
            if (response.status.contains("error")) {
              ScaffoldMessenger.of(context)
                  .showSnackBar(showErrorSnackBar(response.message));
            } else {
              ScaffoldMessenger.of(context)
                  .showSnackBar(showSuccessSnackBar(response.message));
            }
          }
        } catch (e) {
          rethrow;
        }
      },
      style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(appCirclularBorderRadius),
          ),
          backgroundColor: widget.lesson.results.status.contains("completed")
              ? AppColors.accentColor
              : AppColors.successColor),
      child: Text(
        "Mark Finished",
        style: AppTextStyles.labelLarge,
      ),
    );
  }

  Widget nextLesson(BuildContext context) {
    return GestureDetector(
      onTap: () {
        try {
          for (int i = 0; i < widget.lessonItems.length; i++) {
            if (widget.lessonItems[i].id == widget.lesson.id) {
              final newLessonId = widget.lessonItems[i + 1].id;
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                return LoadLessonScreen(
                    lessonId: newLessonId, items: widget.lessonItems);
              }));
            }
          }
        } catch (e) {
          ScaffoldMessenger.of(context)
              .showSnackBar(showErrorSnackBar("No more lessons found"));
          rethrow;
        }
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            children: [
              Text(
                "Continue to Next Lesson",
                style: AppTextStyles.labelLarge,
              ),
              Gap(AppLayout.getWidth(appDefaultSpacing / 2)),
              const Icon(
                FontAwesomeIcons.arrowRight,
                size: 20,
              )
            ],
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
