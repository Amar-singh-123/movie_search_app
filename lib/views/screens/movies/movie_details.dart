import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movie_search_app/controllers/app_controllers.dart';
import 'package:movie_search_app/models/app_models.dart';
import 'package:movie_search_app/services/app_services.dart';
import 'package:movie_search_app/views/utils/app_utils.dart';

class MovieDetailsScreen extends StatelessWidget {
  MovieDetailsScreen(
      {super.key,
      required this.previousPageTitle,
      required this.movieDetailsFuture,
      required this.movieCastsFuture,
      required this.movieImagesFuture,
      required this.similarMoviesDataFuture,
      required this.recommendationMoviesDataFuture});

  final String previousPageTitle;
  final Future<MovieDetailsData> movieDetailsFuture;
  final Future<MovieCreditListData> movieCastsFuture;
  final Future<MovieListData> similarMoviesDataFuture;
  final Future<MovieImageListData> movieImagesFuture;
  final Future<MovieListData> recommendationMoviesDataFuture;
  final MovieApi movieApi = MovieApi();
  var searchController = Get.put(MovieSearchController(movieApi: MovieApi()));

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: const Border(),
        trailing: Obx(
          () => searchController.onlineStatus.value == false
              ? const InternetChecker()
              : const SizedBox(),
        ),
        leading: CupertinoNavigationBarBackButton(
          previousPageTitle: previousPageTitle,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      child: SafeArea(
        child: FutureBuilder<MovieDetailsData>(
            future: movieDetailsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              }
              if (snapshot.hasError) {
                return const Center(
                  child: Text("No Details Found"),
                );
              }
              if (!snapshot.hasData) {
                return const Center(
                  child: Text("No Details Found"),
                );
              }
              if (snapshot.data == null) {
                return const Center(
                  child: Text("No Details Found"),
                );
              }
              var movieDetails = snapshot.data!;
              return ListView(
                shrinkWrap: true,
                padding: 20.topPadding,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      movieDetails.title ?? '',
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipRRect(
                        borderRadius: 15.borderRadius,
                        child: Image.network(
                          movieDetails.backdropPath?.generateImageUrl ?? '',
                          fit: BoxFit.fill,
                          width: context.screenWidth,
                          height: 400,
                          scale: 0.1,
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${movieDetails.genres?.first.name} - 2024 - ${(movieDetails.runtime ?? 0) ~/ 60} hours, ${(movieDetails.runtime ?? 0) % 60} minutes',
                          style: const TextStyle(
                            fontSize: 16,
                            color: CupertinoColors.systemGrey,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          movieDetails.overview ?? '',
                          style: const TextStyle(fontSize: 16),
                        ),
                        16.height,
                        Row(
                          children: [
                            RatingBar(
                                numberOfRating:
                                    movieDetails.voteAverage?.toInt() ?? 0),
                            const SizedBox(width: 10),
                            Text(
                              "${movieDetails.voteAverage?.toInt() ?? '0'}/10",
                              style: const TextStyle(fontSize: 18),
                            ),
                          ],
                        ),
                       23.height,
                        castsAndCrewView(),
                        moreImagesView(),
                        MovieWithTitleWidget(
                            title: "Similar Movies",
                            movieListData: similarMoviesDataFuture,
                            movieApi: movieApi,
                            onTap: (item) => onTap(item, context)),
                        MovieWithTitleWidget(
                          title: "Recommendation",
                          movieListData: recommendationMoviesDataFuture,
                          movieApi: movieApi,
                          onTap: (item) => onTap(item, context),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }

  castsAndCrewView() {
    return FutureBuilder<MovieCreditListData>(
      future: movieCastsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          const Row(
            children: [
              Expanded(
                  child: Center(
                child: CupertinoActivityIndicator(),
              ))
            ],
          );
        }
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data?.crew == null ||
            snapshot.data?.crew?.isEmpty == true) {
          return const Row(
            children: [],
          );
        }

        var crew = snapshot.data!.crew!;
        return ListView.builder(
          itemCount: crew.length > 5 ? 5 : crew.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var currentItem = crew[index];
            return CupertinoListTile(
              padding: 0.allPadding,
              title: Text(currentItem.knownForDepartment?.name ?? ''),
              trailing: Text(currentItem.name ?? ''),
            );
          },
        );
      },
    );
  }

  moreImagesView() {
    return FutureBuilder<MovieImageListData>(
      future: movieImagesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          const Row(
            children: [
              Expanded(
                  child: Center(
                child: CupertinoActivityIndicator(),
              ))
            ],
          );
        }
        if (!snapshot.hasData ||
            snapshot.data == null ||
            snapshot.data?.backdrops == null ||
            snapshot.data?.backdrops?.isEmpty == true) {
          return const Row(
            children: [],
          );
        }
        var imagesList = snapshot.data!.backdrops!;
        imagesList.shuffle();
        return PhysicalModel(
          shape: BoxShape.rectangle,
          color: CupertinoColors.transparent,
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    10.width,
                    Text(
                      'Images',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                10.height,
                SizedBox(
                  width: context.width,
                  height: 360,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1.8,
                    ),
                    shrinkWrap: true,
                    itemCount: imagesList.length > 6 ? 6 : imagesList.length,
                    itemBuilder: (context, index) {
                      var currentItem = imagesList[index];
                      return Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: ClipRRect(
                            borderRadius: 5.borderRadius,
                            child: Image.network(
                              currentItem.filePath?.generateImageUrl ?? '',
                              fit: BoxFit.fill,
                              scale: 0.1,
                            )),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  onTap(Result movieItem, BuildContext context) async {
    if (!searchController.onlineStatus.value) {
      Get.snackbar('No Internet Connection', 'Check Your Internet Connection');
      return;
    }
    var id = movieItem.id;
    var movieDetails = movieApi.getMovieDetails(movieId: id);
    var credits = movieApi.getMovieCredits(movieId: id);
    var recommendationMoviesData = movieApi.getMovieRecommendation(movieId: id);
    var similarMoviesData = movieApi.getSimilarMovies(movieId: id);
    var movieImages = movieApi.getMovieImages(movieId: id);
    Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (context) => MovieDetailsScreen(
            previousPageTitle: '${movieItem.title}',
            movieDetailsFuture: movieDetails,
            movieCastsFuture: credits,
            movieImagesFuture: movieImages,
            similarMoviesDataFuture: similarMoviesData,
            recommendationMoviesDataFuture: recommendationMoviesData,
          ),
        ));
  }
}
