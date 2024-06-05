import 'package:dartz/dartz.dart';
import 'package:movie_zone/domain/entities/app-error.dart';

abstract class Usecase<Type, Parm> {
  Future<Either<AppError, Type>> call(Parm parm);
}
