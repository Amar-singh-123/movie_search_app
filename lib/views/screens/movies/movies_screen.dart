import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movie_search_app/controllers/app_controllers.dart';
import 'package:movie_search_app/models/app_models.dart';
import 'package:movie_search_app/services/app_services.dart';
import 'package:movie_search_app/views/utils/app_utils.dart';

class MoviesScreen extends StatelessWidget {
  MoviesScreen({super.key});

  var controller = Get.put(MovieController(movieApi: MovieApi()));
  final MovieApi movieApi = MovieApi();

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
        navigationBar:  CupertinoNavigationBar(
          leading: const Text(
            "The MovieDb",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
          ),
          border: const Border(),
          trailing: Obx(
                () => controller.onlineStatus.value == false
                ? const InternetChecker()
                : const SizedBox(),
          ),
        ),
        child: SafeArea(
          child: Obx(() {
            if(controller.movieByCategoryList.isEmpty){
              return const Center(child: Text("No Internet Connection"),);
            }
            return ListView.builder(
              shrinkWrap: true,
              padding: 20.topPadding,
              itemCount: controller.movieByCategoryList.length ?? 0,
              itemBuilder: (context, index) {
                var currentMovieWithCategory =
                controller.movieByCategoryList[index];
                return MovieWithTitleWidget(
                  isLandscape: currentMovieWithCategory.category ==
                      Category.upcoming ||
                      currentMovieWithCategory.category == Category.popular,
                  title: currentMovieWithCategory
                      .category.name.formateCategoryName,
                  movieApi: movieApi,
                  onTap: (movieItem) => controller.onItemTap(
                      id: movieItem.id, context: context),
                  movieListData:
                  Future.value(currentMovieWithCategory.movieListData),
                );
              },
            );
          }),
        ));
  }
}
