import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:get/get.dart';
import 'package:movie_zone/constants/theme.dart';
import 'package:movie_zone/controllers/movie-controller.dart';
import 'package:movie_zone/presentation/widgets/text.dart';
import 'package:movie_zone/utils/util.dart';
import '../../../constants/apis.dart';

class MovieDetailPage extends StatelessWidget {
  const MovieDetailPage({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    final movieController = Get.find<MovieController>();
    movieController.fetchMovieDetails(id);

    return Scaffold(
      backgroundColor: AppTheme.black,
      body: Container(
        color: AppTheme.black,
        width: double.infinity,
        child: Obx(() {
          if (movieController.isMovieDetailsLoading.isFalse) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MoviePoster(movieController: movieController),
                  Util.box(size: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child:
                        MovieDetailsContent(movieController: movieController),
                  ),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: AppTheme.orange,
              ),
            );
          }
        }),
      ),
    );
  }
}

class MovieDetailsContent extends StatelessWidget {
  const MovieDetailsContent({super.key, required this.movieController});

  final MovieController movieController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTitleAndRating(movieController: movieController),
        Util.box(),
        Row(
          children: [
            const Icon(
              Icons.star_sharp,
              color: AppTheme.orange,
              size: 15,
            ),
            Util.box(size: 3),
            TextW(
              title: movieController.movieDetails.value.voteAverage.toString(),
            ),
          ],
        ),
        Util.box(),
        const TextW(
          title: "Release date",
          size: 16,
          weight: FontWeight.w400,
        ),
        Util.box(size: 5),
        MovieReleaseDate(movieController: movieController),
        Util.box(),
        Divider(
          color: AppTheme.white.withOpacity(0.3),
        ),
        Util.box(),
        const TextW(
          title: "Synopsis",
          size: 16,
          weight: FontWeight.w400,
        ),
        Util.box(size: 8),
        MovieSynopsis(movieController: movieController),
        Util.box(size: 14),
        const TextW(
          title: "Related Movies",
          size: 16,
          weight: FontWeight.w400,
        ),
        Util.box(),
        RelatedMovieList(movieController: movieController)
      ],
    );
  }
}

class MovieTitleAndRating extends StatelessWidget {
  const MovieTitleAndRating({super.key, required this.movieController});

  final MovieController movieController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextW(
          title: movieController.movieDetails.value.title,
          size: 20,
          weight: FontWeight.w400,
        ),
      ],
    );
  }
}

class MovieReleaseDate extends StatelessWidget {
  const MovieReleaseDate({super.key, required this.movieController});

  final MovieController movieController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.date_range,
          color: AppTheme.orange,
          size: 15,
        ),
        Util.box(),
        TextW(
          title: movieController.movieDetails.value.releaseDate ?? "No date",
          size: 13,
          weight: FontWeight.w400,
        ),
      ],
    );
  }
}

class MovieSynopsis extends StatelessWidget {
  const MovieSynopsis({super.key, required this.movieController});

  final MovieController movieController;

  @override
  Widget build(BuildContext context) {
    return TextW(
      title: movieController.movieDetails.value.overview ??
          "No synopsis available",
      size: 13,
      weight: FontWeight.w400,
    );
  }
}

class RelatedMovieList extends StatelessWidget {
  const RelatedMovieList({super.key, required this.movieController});

  final MovieController movieController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100.0,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(
            movieController.allMovies.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  width: 150,
                  fit: BoxFit.cover,
                  placeholder: (context, url) =>
                      const CircularProgressIndicator(
                    color: AppTheme.orange,
                  ),
                  imageUrl:
                      "${ApiConstants.baseImageUrl}${movieController.allMovies[index].posterPath}",
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  const MoviePoster({super.key, required this.movieController});

  final MovieController movieController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300.0,
      child: Stack(
        children: [
          CachedNetworkImage(
            height: 300.0,
            width: double.infinity,
            fit: BoxFit.cover,
            placeholder: (context, url) => const CircularProgressIndicator(
              color: AppTheme.orange,
            ),
            imageUrl:
                "${ApiConstants.baseImageUrl}${movieController.movieDetails.value.posterPath}",
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 100.0,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    AppTheme.black.withOpacity(0.8),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
