import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable {
  final String backdropPath;
  final int id;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final bool adult;
  final String title;
  final double popularity;
  final DateTime releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;

  const MovieEntity(
      {required this.backdropPath,
      required this.id,
      required this.originalTitle,
      required this.overview,
      required this.posterPath,
      required this.adult,
      required this.title,
      required this.popularity,
      required this.releaseDate,
      required this.video,
      required this.voteAverage,
      required this.voteCount});

  @override
  List<Object?> get props => [id, title];

  @override
  bool get stringify => true;
}
