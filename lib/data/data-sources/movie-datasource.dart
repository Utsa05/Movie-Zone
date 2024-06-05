import 'package:movie_zone/data/core/api-client.dart';
import 'package:movie_zone/data/models/movie-response-model.dart';

import '../models/movie-details.dart';

abstract class MovieDatasource {
  Future<List<Movie>> getTrending();
  Future<List<Movie>> getPopular();
  Future<List<Movie>> getUpcomming();
  Future<List<Movie>> getnowPlaying();
  Future<MovieDetailModel> getMovieDetail(int id);
}

class MovieDatasourceImpl extends MovieDatasource {
  final ApiClient _apiClient;

  MovieDatasourceImpl({required ApiClient apiClient}) : _apiClient = apiClient;
  @override
  Future<List<Movie>> getTrending() async {
    final reponse = await _apiClient.get('trending/movie/day');

    final movies = MovieResponseModel.fromJson(reponse).results;

    return movies;
  }

  @override
  Future<List<Movie>> getPopular() async {
    final reponse = await _apiClient.get('movie/popular');
    final movies = MovieResponseModel.fromJson(reponse).results;
    return movies;
  }

  @override
  Future<List<Movie>> getUpcomming() async {
    final reponse = await _apiClient.get('movie/upcoming');
    final movies = MovieResponseModel.fromJson(reponse).results;
    return movies;
  }

  @override
  Future<List<Movie>> getnowPlaying() async {
    final reponse = await _apiClient.get('movie/now_playing');
    final movies = MovieResponseModel.fromJson(reponse).results;
    return movies;
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final response = await _apiClient.get('movie/$id');
    final movie = MovieDetailModel.fromJson(response);
    if (_isValidMovieDetail(movie)) {
      return movie;
    }
    throw Exception();
  }

  bool _isValidMovieDetail(MovieDetailModel movie) {
    return movie.id != -1 &&
        movie.title.isNotEmpty &&
        movie.posterPath.isNotEmpty;
  }
}
