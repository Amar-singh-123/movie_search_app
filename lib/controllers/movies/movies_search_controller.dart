import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movie_search_app/models/app_models.dart';
import 'package:movie_search_app/services/app_services.dart';
import 'package:movie_search_app/views/screens/app_screens.dart';
import 'package:movie_search_app/views/utils/app_utils.dart';

class MovieSearchController extends GetxController {
   RxBool onlineStatus = true.obs;
  MovieSearchController({required this.movieApi});
  final RxBool _isLoading = false.obs;
  bool get isLoading => _isLoading.value;

  updateLoading(bool v) => _isLoading.value = v;
  final MovieApi movieApi;
  final Rx<MovieListData> searchedMovieList = MovieListData(results: null).obs;
  final RxString _searchQuery = "".obs;

  void searchMovie(String searchQuery) async {
    _searchQuery.value = searchQuery;
    updateLoading(true);
    if (searchQuery.isNotEmpty) {
      var searchedList = await movieApi.searchMovies(query: searchQuery);
      searchedMovieList.value = searchedList;
    }
    updateLoading(false);
  }

  void showMessage({
    required String title,
    required String message,
    bool? success,
    bool? error,
  }) {
    if (error == true) {
      Get.snackbar(title, message,
          backgroundColor: AppColors.red.withOpacity(0.6));
      return;
    } else {
      Get.snackbar(title, message,
          backgroundColor: AppColors.green.withOpacity(0.6));
      return;
    }
  }

  void onSearchedItemTap(
      {required int index,
      required int? movieId,
      required BuildContext context}) async {
    if (!onlineStatus.value) {
      Get.snackbar('No Internet Connection', 'Check Your Internet Connection');
      return;
    }
    var movieDetails = movieApi.getMovieDetails(movieId: movieId);
    var credits = movieApi.getMovieCredits(movieId: movieId);
    var recommendationMoviesData =
        movieApi.getMovieRecommendation(movieId: movieId);
    var similarMoviesData = movieApi.getSimilarMovies(movieId: movieId);
    var movieImages = movieApi.getMovieImages(movieId: movieId);
    Navigator.push(
        context,
        CupertinoPageRoute(
            builder: (context) => MovieDetailsScreen(
                  previousPageTitle: 'Search',
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
      },
    );
  }

  @override
  void onInit() {
    checkInternetStatus();
    super.onInit();
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
