import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:movie_search_app/models/app_models.dart';
import 'package:movie_search_app/services/apis/movie_api_service.dart';
import 'package:movie_search_app/views/screens/app_screens.dart';
import 'package:movie_search_app/views/utils/app_utils.dart';

class MovieItemWidget extends StatelessWidget {
  final double height;
  final double width;
  final bool isLandScape;
  final Result movieItem;
  final MovieApi movieApi;
  final Function(Result movieId) onTap;
  final int index;

  const MovieItemWidget({
    super.key,
    this.height = 330,
    this.width = 210,
    required this.movieItem,
    required this.index,
    this.isLandScape = false,
    required this.movieApi,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => onTap(movieItem),
        child: ClipRRect(
          borderRadius: 10.borderRadius,
          child: Image.network(
            (isLandScape
                    ? movieItem.backdropPath ??
                        '/aKPCZwkSZy2ASLo0QKeYmcoplfA.jpg'
                    : movieItem.posterPath ??
                        '/aKPCZwkSZy2ASLo0QKeYmcoplfA.jpg')
                .generateImageUrl,
            height: isLandScape ? width : height,
            width: isLandScape ? height : width,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
