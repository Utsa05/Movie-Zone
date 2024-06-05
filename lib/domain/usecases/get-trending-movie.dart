import 'package:dartz/dartz.dart';
import 'package:movie_zone/domain/entities/app-error.dart';
import 'package:movie_zone/domain/entities/movie-entity.dart';
import 'package:movie_zone/domain/entities/no-param.dart';
import 'package:movie_zone/domain/repositories/movie-repositories.dart';
import 'package:movie_zone/domain/usecases/usecase.dart';

class GetTrendingUsecase extends Usecase<List<MovieEntity>, NoParm> {
  final MovieRepoistories _movieRepoistories;

  GetTrendingUsecase({required MovieRepoistories movieRepoistories})
      : _movieRepoistories = movieRepoistories;

  @override
  Future<Either<AppError, List<MovieEntity>>> call(NoParm parm) async {
    return await _movieRepoistories.getTrending();
  }
}
