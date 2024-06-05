import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:movie_zone/data/data-sources/movie-datasource.dart';
import 'package:movie_zone/data/models/movie-response-model.dart';
import 'package:movie_zone/domain/entities/app-error.dart';
import 'package:movie_zone/domain/entities/movie-details-entity.dart';
import 'package:movie_zone/domain/entities/movie-entity.dart';
import 'package:movie_zone/domain/repositories/movie-repositories.dart';
import 'package:movie_zone/enums/app-error-type.dart';

class MovieRepoistoriesImpl extends MovieRepoistories {
  final MovieDatasource _movieDatasource;

  MovieRepoistoriesImpl({required MovieDatasource movieDatasource})
      : _movieDatasource = movieDatasource;

  @override
  Future<Either<AppError, List<MovieEntity>>> getPopular() async {
    try {
      final movies = await _movieDatasource.getPopular();
      return right(movies);
    } on SocketException {
      return left(const AppError(
          message: "No Internet Connection", errorType: AppErrorType.network));
    } catch (e) {
      return left(AppError(message: e.toString(), errorType: AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getTrending() async {
    try {
      final movies = await _movieDatasource.getTrending();
      return right(movies);
    } on SocketException {
      return left(const AppError(
          message: "No Internet Connection", errorType: AppErrorType.network));
    } catch (e) {
      return left(AppError(message: e.toString(), errorType: AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, MovieDetailEntity>> getMovieDetail(int id) async {
    try {
      final movies = await _movieDatasource.getMovieDetail(id);
      return right(movies);
    } on SocketException {
      return left(const AppError(
          message: "No Internet Connection", errorType: AppErrorType.network));
    } catch (e) {
      return left(AppError(message: e.toString(), errorType: AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getUpcomming() async {
    try {
      final movies = await _movieDatasource.getUpcomming();
      return right(movies);
    } on SocketException {
      return left(const AppError(
          message: "No Internet Connection", errorType: AppErrorType.network));
    } catch (e) {
      return left(AppError(message: e.toString(), errorType: AppErrorType.api));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>>> getnowPlaying() async {
    try {
      final movies = await _movieDatasource.getnowPlaying();
      return right(movies);
    } on SocketException {
      return left(const AppError(
          message: "No Internet Connection", errorType: AppErrorType.network));
    } catch (e) {
      return left(AppError(message: e.toString(), errorType: AppErrorType.api));
    }
  }
}
