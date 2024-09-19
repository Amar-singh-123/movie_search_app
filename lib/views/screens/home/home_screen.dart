import 'package:flutter/cupertino.dart';
import 'package:movie_search_app/views/screens/app_screens.dart';
import 'package:movie_search_app/views/utils/app_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
        activeColor: AppColors.blue,
        height: 65,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.tv),
            label: 'Home',
            tooltip: "Home"
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
            tooltip: "Search"
          ),
        ],
      ),
      tabBuilder: (context, index) {
        switch (index) {
          case 0:
            return CupertinoTabView(
              builder: (context) => MoviesScreen(),
            );
          case 1:
            return CupertinoTabView(
              builder: (context) => SearchScreen(),
            );
          default:
            return CupertinoTabView(
              builder: (context) => MoviesScreen(),
            );
        }
      },
    );
  }
}
