import 'package:fablearner_app/design/screens/home_screen/home_screen_drawer.dart';
import 'package:fablearner_app/design/screens/home_screen/home_screen_header.dart';
import 'package:fablearner_app/design/screens/home_screen/home_course_card.dart';
import 'package:fablearner_app/design/screens/section_screen/sections_screen.dart';
import 'package:fablearner_app/providers/courses_provider.dart';
import 'package:fablearner_app/providers/drawer_state_provider.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _homeScreenKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    void openDrawer() {
      _homeScreenKey.currentState?.openDrawer();
    }

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        key: _homeScreenKey,
        drawer: const HomeScreenDrawer(),
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              leading: IconButton(
                onPressed: () {
                  Provider.of<DrawerStateProvider>(context, listen: false)
                      .setDrawerState(true);

                  openDrawer();
                },
                icon: const Icon(
                  FontAwesomeIcons.barsStaggered,
                  color: AppColors.textColor,
                ),
              ),
              automaticallyImplyLeading: false,
              centerTitle: false,
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "FabLearner",
                  style: AppTextStyles.displaySmall,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SingleChildScrollView(child: HomeScreenHeader()),
            ),
            SliverPadding(
                padding: EdgeInsets.only(
                    right: appDefaultPadding,
                    left: appDefaultPadding,
                    top: appDefaultPadding / 2,
                    bottom: appDefaultPadding * 4),
                sliver: Consumer<CoursesProvider>(
                  builder: (context, coursesProvider, child) {
                    final courses = coursesProvider.coursesModel;
                    return SliverGrid(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 200,
                        crossAxisCount: 2,
                        crossAxisSpacing: appDefaultSpacing,
                        mainAxisSpacing: appDefaultSpacing,
                      ),
                      delegate: SliverChildBuilderDelegate(
                        childCount: courses.length,
                        (context, index) {
                          final course = courses[index];
                          return HomeCourseCard(
                            course: course,
                            onTap: () {
                              try {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Consumer<CoursesProvider>(
                                    builder: (context, coursesProvider, child) {
                                      // Pass the updated course from the provider here
                                      final course =
                                          coursesProvider.coursesModel[index];
                                      return SectionsScreen(
                                        course: course,
                                      );
                                    },
                                  );
                                }));
                              } catch (e) {
                                showErrorToast("Something went wrong.");
                                rethrow;
                              }
                            },
                          );
                        },
                      ),
                    );
                  },
                )),
          ],
        ),
      ),
    );
  }
}
