import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movie_search_app/models/app_models.dart';
import 'package:movie_search_app/services/app_services.dart';
import 'package:movie_search_app/views/utils/app_utils.dart';

class MovieWithTitleWidget extends StatelessWidget {
  const MovieWithTitleWidget({
    super.key,
    required this.movieListData,
    required this.title,
    required this.movieApi,
    this.isLandscape = false,
     this.onTap,
  });

  final Future<MovieListData> movieListData;
  final String title;
  final bool isLandscape;
  final MovieApi movieApi;
  final Function(Result movieItem)? onTap;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MovieListData>(
      future: movieListData,
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
            snapshot.data?.results == null ||
            snapshot.data?.results?.isEmpty == true) {
          return const Row(
            children: [],
          );
        }

        var movieItemList = snapshot.data!.results!;
        return PhysicalModel(
          shape: BoxShape.rectangle,
          color: CupertinoColors.transparent,
          child: Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Row(
                  children: [
                    10.width,
                    Text(
                      title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                10.height,
                SizedBox(
                  width: context.width,
                  height: isLandscape ? 200 : 300,
                  child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: movieItemList.length,
                    itemBuilder: (context, index) {
                      var currentMovie = movieItemList[index];
                      return MovieItemWidget(
                          isLandScape: isLandscape,
                          movieItem: currentMovie ?? Result(),
                          index: index,
                          movieApi: movieApi,
                          onTap:onTap ??  (v){});
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
}
