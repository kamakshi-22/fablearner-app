import 'package:fablearner_app/design/screens/lesson/load_lesson_screen.dart';
import 'package:fablearner_app/design/widgets/linearProgressIndicator.dart';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:fablearner_app/providers/data/user_provider.dart';
import 'package:fablearner_app/providers/services/service_provider.dart';
import 'package:fablearner_app/utils/layout.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';

class SectionsScreenBody extends StatefulWidget {
  final CourseModel course;
  final TabController? tabController;
  const SectionsScreenBody(
      {super.key, required this.course, this.tabController});

  @override
  State<SectionsScreenBody> createState() => _SectionsScreenBodyState();
}

class _SectionsScreenBodyState extends State<SectionsScreenBody> {
  @override
  Widget build(BuildContext context) {
    final serviceProvider = Provider.of<ServiceProvider>(context);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String token = userProvider.user.token;
    return Padding(
      padding:
          EdgeInsets.only(top: AppLayout.getHeight(appCirclularBorderRadius)),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.backgroundColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(appCirclularBorderRadius),
              topRight: Radius.circular(appCirclularBorderRadius),
            )),
        child: TabBarView(
          controller: widget.tabController,
          children: buildTabBarView(token, serviceProvider),
        ),
      ),
    );
  }

  List<Widget> buildTabBarView(String token, ServiceProvider serviceProvider) {
    List<Widget> list = []; // stores section's items
    final sections = widget.course.sections;
    final progressPercent = sections[widget.tabController!.index].percent;
    final roundedPercent = ((progressPercent * 100).round()) / 100;
    for (int i = 0; i < sections.length; i++) {
      final items = sections[i].items; // current section's items
      List<Widget> sectionItemsList = []; // stores widgets for current item
      for (int j = 0; j < items.length; j++) {
        final item = items[j]; // current item
        sectionItemsList.add(
            /* LESSON ITEM */
            LessonItem(
          item: item,
          items: items,
        ));
      }
      list.add(Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: appDefaultPadding, vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /* PROGRESS */
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Your Progress",
                          style: AppTextStyles.bodySmall
                              .copyWith(color: AppColors.accentColor),
                        ),
                        Text(
                          "$roundedPercent% completed",
                          style: AppTextStyles.headlineSmall
                              .copyWith(color: AppColors.primaryColor),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: appCourseImageSize / 2,
                      child: Hero(
                        tag: "${widget.course.id}",
                        child: Image.asset(
                          "assets/images/notebook-3D.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                Gap(AppLayout.getHeight(8)),

                /* LINEAR PROGRESS INDICATOR */
                AppLinearProgressIndicator(progressPercent: progressPercent)
              ],
            ),
          ),
          Expanded(
            child: ListView(
              /* LESSONS LIST */
              children: sectionItemsList,
            ),
          ),
        ],
      ));
    }
    return list;
  }
}

class LessonItem extends StatelessWidget {
  final Item item;
  final List<Item> items;
  const LessonItem({super.key, required this.item, required this.items});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LoadLessonScreen(
            lessonId: item.id,
            items: items,
          );
        }));
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
                  color: item.status.toString().contains("COMPLETED")
                      ? AppColors.successColor
                      : AppColors.accentColor,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 12.0),
                  height: AppLayout.getHeight(24),
                  width: AppLayout.getHeight(4),
                  decoration: BoxDecoration(
                    color: item.status.toString().contains("COMPLETED")
                        ? AppColors.successColor
                        : AppColors.accentColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                )
              ],
            ),
            Gap(AppLayout.getWidth(20)),
            Text(
              item.title,
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
