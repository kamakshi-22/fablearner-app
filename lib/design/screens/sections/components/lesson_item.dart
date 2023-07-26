import 'package:fablearner_app/design/screens/lesson/lesson_screen.dart';
import 'package:fablearner_app/design/widgets/error_screen.dart';
import 'package:fablearner_app/design/widgets/loading_Screen.dart';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/models/lesson_model.dart';
import 'package:fablearner_app/providers/lesson_provider.dart';
import 'package:fablearner_app/providers/user_provider.dart';
import 'package:fablearner_app/utils/layout.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class LessonItem extends StatefulWidget {
  final Item item;
  final List<Item> items;
  const LessonItem({super.key, required this.item, required this.items});

  @override
  State<LessonItem> createState() => _LessonItemState();
}

class _LessonItemState extends State<LessonItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        try {
          final userProvider =
              Provider.of<UserProvider>(context, listen: false);
          final String token = userProvider.user.token;
          final lessonProvider =
              Provider.of<LessonProvider>(context, listen: false);
          await lessonProvider.fetchLessonModel(widget.item.id, token);
          if (mounted) //if widget disposed don't navigate
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LessonScreen(
                lessonItems: widget.items,
              );
            }));
          }
        } catch (e) {
          showErrorToast("Something went wrong.");
          rethrow;
        }
      },
      child: Container(
        padding:
            EdgeInsets.symmetric(horizontal: appDefaultPadding, vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Icon(
                  FontAwesomeIcons.solidCircleCheck,
                  color: widget.item.status.toString().contains("COMPLETED")
                      ? AppColors.successColor
                      : AppColors.accentColor,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12.0),
                  height: AppLayout.getHeight(24),
                  width: AppLayout.getHeight(4),
                  decoration: BoxDecoration(
                    color: widget.item.status.toString().contains("COMPLETED")
                        ? AppColors.successColor
                        : AppColors.accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              ],
            ),
            Gap(AppLayout.getWidth(20)),
            Text(
              widget.item.title,
              style: AppTextStyles.bodyMedium.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}


/* Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return Consumer<LessonProvider>(
                  builder: (context, lessonProvider, child) {
                    final userProvider =
                        Provider.of<UserProvider>(context, listen: false);
                    final String token = userProvider.user.token;
                    return FutureBuilder(
                      future: lessonProvider.fetchLessonModel(widget.item.id, token),
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return const LoadingScreen();
                          case ConnectionState.active:
                          case ConnectionState.waiting:
                            return const LoadingScreen();
                          case ConnectionState.done:
                            if (snapshot.hasError) {
                              printIfDebug(snapshot.error);
                              return const ErrorScreen(
                                  text: "Encountered error. Please try again.");
                            } else {

                              
                              return LessonScreen(
                                lessonItems: widget.items,
                              );
                            }
                          default:
                            return const ErrorScreen(
                                text: 'Unknown connection state');
                        }
                      },
                    );
                  },
                );
              },
            ),
          ); */