import 'package:fablearner_app/design/screens/lesson/load_lesson_screen.dart';
import 'package:fablearner_app/design/widgets/widgets.dart';
import 'package:fablearner_app/utils/layout.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fablearner_app/models/courses_model.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';

class SectionsScreen extends StatefulWidget {
  final CoursesModel course;
  const SectionsScreen({super.key, required this.course});

  @override
  State<SectionsScreen> createState() => _SectionsScreenState();
}

class _SectionsScreenState extends State<SectionsScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: widget.course.sections.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          floatingActionButton: FloatingActionButton(
            backgroundColor: AppColors.primaryColor,
            onPressed: () {
              _tabController!.index++;
            },
            child: const Icon(FontAwesomeIcons.chevronRight),
          ),
          backgroundColor: AppColors.primaryColor,
          body: NestedScrollView(
            headerSliverBuilder: (context, bool innerBoxIsScrolled) {
              return [buildAppBar(context)];
            },
            body: buildBody(),
          )),
    );
  }

  Padding buildBody() {
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
          controller: _tabController,
          children: buildTabBarView(),
        ),
      ),
    );
  }

  List<Widget> buildTabBarView() {
    List<Widget> list = []; // stores section's items
    final sections = widget.course.sections;
    final progressPercent = sections[_tabController!.index].percent;
    for (int i = 0; i < sections.length; i++) {
      final items = sections[i].items; // current section's items
      List<Widget> sectionItemsList = []; // stores widgets for current item
      for (int j = 0; j < items.length; j++) {
        final item = items[j]; // current item
        sectionItemsList.add(
          /* LESSON ITEM */
          GestureDetector(
            onTap: () {
             
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return LoadLessonScreen(
                  lessonId: item.id,
                  items: items,
                );
              }));
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                  horizontal: appDefaultPadding, vertical: 8.0),
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
          ),
        );
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
                          "$progressPercent% completed",
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

  SliverAppBar buildAppBar(BuildContext context) {
    return SliverAppBar(
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
      title: Text(
        widget.course.name,
        style: AppTextStyles.displaySmall.copyWith(
          color: AppColors.backgroundColor,
        ),
      ),
      bottom: TabBar(
          isScrollable: true,
          indicatorColor: AppColors.backgroundColor,
          indicatorWeight: 4,
          indicatorSize: TabBarIndicatorSize.label,
          controller: _tabController,
          tabs: buildTabs()),
    );
  }

  List<Widget> buildTabs() {
    List<Widget> list = [];
    final sections = widget.course.sections;
    for (int i = 0; i < sections.length; i++) {
      list.add(Text(
        sections[i].title,
        style: AppTextStyles.titleMedium
            .copyWith(color: AppColors.backgroundColor),
      ));
    }
    return list;
  }
}


