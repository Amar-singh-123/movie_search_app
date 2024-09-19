
import '../movie_list_data/movie_list_data.dart';

class MovieListByCategory {
  Category category;
  MovieListData movieListData;

  MovieListByCategory({required this.category, required this.movieListData});
}

enum Category {
  now_playing,
  popular,
  upcoming,
  top_rated,
}
