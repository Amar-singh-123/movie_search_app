import 'package:dio/dio.dart';
import 'package:movie_search_app/models/app_models.dart';

class MovieApi {
  final dio = Dio();

 Future<MovieListByCategory> getMoviesByCategory({required Category category, int page=1}) async {
    Response<dynamic>? data;
    try {
      data = await dio.get(
          "http://api.themoviedb.org/3/movie/${category.name}",
          queryParameters: {
            "api_key": "8e85a0e4c5d3d48a2d215bbaffa7590f",
            "language": "en-US",
            "page": page,
          },
          options: Options(contentType: "application/json",));
    } catch (e) {
      print(e);
      print(data?.data);
    }
    if (data?.data != null) {
      var movieByCategory = MovieListByCategory(category: category, movieListData: MovieListData.fromJson(data?.data ?? {}));
      return movieByCategory;
    }
    await Future.delayed(const Duration(milliseconds: 100));
    return await getMoviesByCategory(category: category, page: page);
  }

 Future<MovieListData> searchMovies({required String query,  int page = 1,bool includeAdults = false}) async {
    Response<dynamic>? data;
    try {
      data = await dio.get(
          "https://api.themoviedb.org/3/search/movie",
          queryParameters: {
            "api_key": "8e85a0e4c5d3d48a2d215bbaffa7590f",
            "language": "en-US",
            "query": query,
            "page": page,
            "include_adult": page,
          },
          options: Options(contentType: "application/json",));
    } catch (e) {
      print(e);
      print(data?.data);
    }
    if (data?.data != null) {
      var movieByCategory =  MovieListData.fromJson(data?.data ?? {});
      return movieByCategory;
    }
    await Future.delayed(const Duration(milliseconds: 100));
    return await searchMovies(query: query, page: page);
  }

 Future<MovieListData> getMovieRecommendation({required int? movieId,  int page = 1}) async {
    Response<dynamic>? data;
    try {
      data = await dio.get(
          "https://api.themoviedb.org/3/movie/$movieId/recommendations",
          queryParameters: {
            "api_key": "8e85a0e4c5d3d48a2d215bbaffa7590f",
            "page": page,
          },
          options: Options(contentType: "application/json",));
    } catch (e) {
      print(e);
      print(data?.data);
    }
    if (data?.data != null) {
      var movieByCategory =  MovieListData.fromJson(data?.data ?? {});
      return movieByCategory;
    }
    await Future.delayed(const Duration(milliseconds: 100));
    return await getMovieRecommendation(movieId: movieId, page: page);
  }

 Future<MovieListData> getSimilarMovies({required int? movieId,  int page = 1}) async {
    Response<dynamic>? data;
    try {
      data = await dio.get(
          "https://api.themoviedb.org/3/movie/$movieId/similar",
          queryParameters: {
            "api_key": "8e85a0e4c5d3d48a2d215bbaffa7590f",
            "page": page,
          },
          options: Options(contentType: "application/json",));
    } catch (e) {
      print(e);
      print(data?.data);
    }
    if (data?.data != null) {
      var movieByCategory =  MovieListData.fromJson(data?.data ?? {});
      return movieByCategory;
    }
    await Future.delayed(const Duration(milliseconds: 100));
    return await getSimilarMovies(movieId: movieId, page: page);
  }

 Future<MovieDetailsData> getMovieDetails({required int? movieId}) async {
    Response<dynamic>? data;
    try {
      data = await dio.get(
          "https://api.themoviedb.org/3/movie/$movieId",
          queryParameters: {
            "api_key": "8e85a0e4c5d3d48a2d215bbaffa7590f",
          },
          options: Options(contentType: "application/json",));
    } catch (e) {
      print(e);
      print(data?.data);
    }
    if (data?.data != null) {
      var movieDetailsData =  MovieDetailsData.fromJson(data?.data ?? {});
      return movieDetailsData;
    }
    await Future.delayed(const Duration(milliseconds: 100));
    return await getMovieDetails(movieId: movieId,);
  }

 Future<MovieCreditListData> getMovieCredits({required int? movieId}) async {
    Response<dynamic>? data;
    try {
      data = await dio.get(
          "https://api.themoviedb.org/3/movie/$movieId/credits",
          queryParameters: {
            "api_key": "8e85a0e4c5d3d48a2d215bbaffa7590f",
          },
          options: Options(contentType: "application/json",));
    } catch (e) {
      print(e);
      print(data?.data);
    }
    if (data?.data != null) {
      var movieCreditListData =  MovieCreditListData.fromJson(data?.data ?? {});
      return movieCreditListData;
    }
    await Future.delayed(const Duration(milliseconds: 100));
    return await getMovieCredits(movieId: movieId,);
  }

 Future<MovieImageListData> getMovieImages({required int? movieId}) async {
    Response<dynamic>? data;
    try {
      data = await dio.get(
          "https://api.themoviedb.org/3/movie/$movieId/images",
          queryParameters: {
            "api_key": "8e85a0e4c5d3d48a2d215bbaffa7590f",
          },
          options: Options(contentType: "application/json",));
    } catch (e) {
      print(e);
      print(data?.data);
    }
    if (data?.data != null) {
      var movieImageListData =  MovieImageListData.fromJson(data?.data ?? {});
      return movieImageListData;
    }
    await Future.delayed(const Duration(milliseconds: 100));
    return await getMovieImages(movieId: movieId,);
  }

}
