import 'package:movie_zone/domain/entities/app-error.dart';
import 'package:movie_zone/domain/entities/movie-details-entity.dart';
import 'package:movie_zone/domain/entities/movie-entity.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepoistories {
  Future<Either<AppError, List<MovieEntity>>> getTrending();
  Future<Either<AppError, List<MovieEntity>>> getPopular();
  Future<Either<AppError, List<MovieEntity>>> getUpcomming();
  Future<Either<AppError, List<MovieEntity>>> getnowPlaying();
  Future<Either<AppError, MovieDetailEntity>> getMovieDetail(int id);
}
