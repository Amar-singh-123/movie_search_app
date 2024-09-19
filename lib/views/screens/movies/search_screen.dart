import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_search_app/controllers/app_controllers.dart';
import 'package:movie_search_app/services/app_services.dart';
import 'package:movie_search_app/views/utils/app_utils.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});

  MovieSearchController controller = Get.put(MovieSearchController(movieApi: MovieApi()));

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar:  CupertinoNavigationBar(
        leading: const Text(
          "Search",
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        trailing: Obx(
              () => controller.onlineStatus.value == false
              ? const InternetChecker()
              : const SizedBox(),
        ),        border: const Border(),
      ),
      child: SafeArea(
        child: Obx(() {
          return Column(
            children: [
              20.height,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CupertinoSearchTextField(
                  placeholder: 'Search for movies',
                  prefixIcon: const Icon(
                    CupertinoIcons.search,
                    color: CupertinoColors.systemGrey,
                  ),
                  onChanged: controller.searchMovie,
                ),
              ),
              Expanded(
                child:controller.isLoading ? const Center(child: CupertinoActivityIndicator(),): controller.searchedMovieList.value.results?.isEmpty ==
                    true ||
                    controller.searchedMovieList.value.results == null
                    ? const Center(
                  child: Text("Movie Not Available"),
                )
                    : ListView.separated(
                  separatorBuilder: (context, index) => const Divider(
                    height: 1,
                  ),
                  itemCount:
                  controller.searchedMovieList.value.results!.length,
                  itemBuilder: (context, index) {
                    var movie =
                    controller.searchedMovieList.value.results![index];
                    return CupertinoListTile(
                      onTap: () => controller.onSearchedItemTap(
                          index: index, movieId: movie.id,context:context),
                      title: Text(movie.originalTitle ?? ""),
                      subtitle: Text(movie.releaseDate?.toString().formatDate ?? ""),
                      trailing: const Icon(CupertinoIcons.right_chevron,color: CupertinoColors.black,),
                    );
                  },
                ),
              ),
            ],
          );
        },),
      ),
    );
  }
}
