import 'package:dartz/dartz.dart';
import 'package:movie_zone/domain/entities/app-error.dart';
import 'package:movie_zone/domain/entities/movie-details-entity.dart';
import 'package:movie_zone/domain/repositories/movie-repositories.dart';
import 'package:movie_zone/domain/usecases/usecase.dart';

class GetMovieDetailsUsecase extends Usecase<MovieDetailEntity, int> {
  final MovieRepoistories _movieRepoistories;

  GetMovieDetailsUsecase({required MovieRepoistories movieRepoistories})
      : _movieRepoistories = movieRepoistories;

  @override
  Future<Either<AppError, MovieDetailEntity>> call(int parm) async {
    return await _movieRepoistories.getMovieDetail(parm);
  }
}
