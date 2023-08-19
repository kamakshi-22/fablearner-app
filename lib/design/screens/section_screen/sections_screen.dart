import 'package:fablearner_app/design/screens/section_screen/sections_appbar.dart';
import 'package:fablearner_app/design/screens/section_screen/sections_body.dart';
import 'package:fablearner_app/design/screens/section_screen/sections_button.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:fablearner_app/models/courses_model.dart';

class SectionsScreen extends StatefulWidget {
  final CourseModel course;
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
          floatingActionButton: SectionScreenFloatingActionButton(
            tabController: _tabController!,
            course: widget.course,
          ),
          backgroundColor: AppColors.primaryColor,
          body: NestedScrollView(
            headerSliverBuilder: (context, bool innerBoxIsScrolled) {
              return [
                SectionsAppBar(
                  course: widget.course,
                  tabController: _tabController,
                )
              ];
            },
            body: SectionsScreenBody(
              course: widget.course,
              tabController: _tabController,
            ),
          )),
    );
  }
}
