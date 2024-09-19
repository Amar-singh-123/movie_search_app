import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_search_app/models/app_models.dart';
import 'package:movie_search_app/services/app_services.dart';
import 'package:movie_search_app/views/screens/movies/movie_details.dart';

import '../../views/utils/app_utils.dart';

class MovieController extends GetxController {
  MovieController({required this.movieApi});

  final RxBool onlineStatus = true.obs;
  final MovieApi movieApi;
  final List<Category> _allCategories = [
    Category.now_playing,
    Category.upcoming,
    Category.top_rated,
    Category.popular
  ];
  RxList<MovieListByCategory> movieByCategoryList = <MovieListByCategory>[].obs;

  @override
  void onInit() {
    checkInternetStatus();
    super.onInit();
  }

  void getAllMovies() async {
    var data = await checkOnlineStatus();
    if (!data) {
      Get.snackbar('No Internet Connection', 'Check Your Internet Connection');
      return;
    }
    movieByCategoryList.assignAll([]);
    for (var category in _allCategories) {
      try {
        var moviesByCategory =
            await movieApi.getMoviesByCategory(category: category);
        movieByCategoryList.add(moviesByCategory);
      } catch (e) {
        print('$e');
        showMessage(
            title: "Failed to Get Movie",
            message: "$e",
            success: false,
            error: true);
      }
    }
  }

  void showMessage({
    required String title,
    required String message,
    bool? success,
    bool? error,
  }) {
    if (error == true) {
      Get.snackbar(title, message,
          backgroundColor: Colors.red.withOpacity(0.6));
      return;
    } else {
      Get.snackbar(title, message,
          backgroundColor: AppColors.green.withOpacity(0.6));
      return;
    }
  }

  onItemTap({int? id, required BuildContext context}) async {
    if (!onlineStatus.value) {
      Get.snackbar('No Internet Connection', 'Check Your Internet Connection');
   return;
    }
    var movieDetails = movieApi.getMovieDetails(movieId: id);
    var credits = movieApi.getMovieCredits(movieId: id);
    var recommendationMoviesData = movieApi.getMovieRecommendation(movieId: id);
    var similarMoviesData = movieApi.getSimilarMovies(movieId: id);
    var movieImages = movieApi.getMovieImages(movieId: id);
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => MovieDetailsScreen(
                  previousPageTitle: 'Back',
                  movieDetailsFuture: movieDetails,
                  movieCastsFuture: credits,
                  movieImagesFuture: movieImages,
                  similarMoviesDataFuture: similarMoviesData,
                  recommendationMoviesDataFuture: recommendationMoviesData,
                )));
  }

  void checkInternetStatus() {
    Connectivity().onConnectivityChanged.listen(
      (snapshot) {
        var isOnLine = snapshot.contains(ConnectivityResult.mobile) == true ||
            snapshot.contains(ConnectivityResult.wifi) == true ||
            snapshot.contains(ConnectivityResult.ethernet) == true;
        onlineStatus.value = isOnLine;
        if (isOnLine ) {
          getAllMovies();
        }
      },
    );
  }

  Future<bool> checkOnlineStatus() async {
    var snap = await Connectivity().checkConnectivity();
    var isOnLine = snap.contains(ConnectivityResult.mobile) == true ||
        snap.contains(ConnectivityResult.wifi) == true ||
        snap.contains(ConnectivityResult.ethernet) == true;
    onlineStatus.value = isOnLine;
    return isOnLine;
  }
}
