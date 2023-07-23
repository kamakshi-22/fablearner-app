import 'package:fablearner_app/design/screens/home/home_screen_body.dart';
import 'package:fablearner_app/design/widgets/widgets.dart';
import 'package:fablearner_app/providers/providers.dart';
import 'package:fablearner_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  final String userDisplayName;
  final String authToken;
  const HomeScreen({super.key, required this.authToken, required this.userDisplayName});

  @override
  Widget build(BuildContext context) {
    final dataProvider = Provider.of<DataProvider>(context);

    return Scaffold(
      appBar: buildAppBar(),
      body: FutureBuilder(
        future: dataProvider.fetchAppData(authToken),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return Center(child: errorText('No connection'));
            case ConnectionState.active:
            case ConnectionState.waiting:
              return const Center(child: AppLoadingIndicator());
            case ConnectionState.done:
              final courses = snapshot.data;
              return HomeScreenBody(courses: courses, userDisplayName : userDisplayName);
            default:
              return Center(child: errorText('Unknown connection state'));
          }
        },
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () {},
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
    );
  }
}
