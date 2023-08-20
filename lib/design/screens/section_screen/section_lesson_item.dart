import 'package:fablearner_app/data/user_preferences.dart';
import 'package:fablearner_app/design/screens/lesson_screen/lesson_screen.dart';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/providers/lesson_provider.dart';
import 'package:fablearner_app/providers/user_provider.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SectionLessonItem extends StatefulWidget {
  final Item item;
  final List<Item> items;
  const SectionLessonItem({super.key, required this.item, required this.items});

  @override
  State<SectionLessonItem> createState() => Section_LessonItemState();
}

class Section_LessonItemState extends State<SectionLessonItem> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    final String token =
        UserPreferences.getUserToken() ?? userProvider.user.token;

    final lessonProvider = Provider.of<LessonProvider>(context);
    return GestureDetector(
      onTap: () async {
        try {
          showLoadingIndicator(context);
          await lessonProvider.fetchLessonModel(widget.item.id, token);
        final lesson = lessonProvider.lessonModel;
          if (mounted) //if widget disposed don't navigate
          {
            Navigator.of(context).pop();
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return LessonScreen(lesson: lesson,);
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
            Gap(AppLayout.getWidth(10)),
          ],
        ),
      ),
    );
  }
}
