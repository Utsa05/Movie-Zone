// ignore_for_file: avoid_print

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:movie_zone/domain/entities/movie-details-entity.dart';
import 'package:movie_zone/domain/entities/movie-entity.dart';
import 'package:movie_zone/domain/entities/no-param.dart';
import 'package:movie_zone/domain/usecases/get-moviedetails-usecase.dart';
import 'package:movie_zone/domain/usecases/get-nowplaying-usecase.dart';
import 'package:movie_zone/domain/usecases/get-popular-usecase.dart';
import 'package:movie_zone/domain/usecases/get-trending-movie.dart';

import 'package:movie_zone/domain/usecases/get-upcomming-usecase.dart';

class MovieController extends GetxController {
  var allMovies = <MovieEntity>[].obs;
  var selectedMovies = <MovieEntity>[].obs;
  var trendingMovies = <MovieEntity>[].obs;
  var popularMovies = <MovieEntity>[].obs;
  var upcomingMovies = <MovieEntity>[].obs;
  var nowPlayingMovies = <MovieEntity>[].obs;
  var isMovieLoading = false.obs;
  var isMovieDetailsLoading = false.obs;
  var searchQuery = ''.obs;
  var searchTextController = TextEditingController().obs;
  var movieDetails = const MovieDetailEntity(
          id: 0,
          title: "",
          overview: "",
          releaseDate: "",
          voteAverage: 0,
          backdropPath: "",
          posterPath: "")
      .obs;

  Future<void> fetchAllMovies() async {
    isMovieLoading(true);
    final getTrendingUsecase =
        GetTrendingUsecase(movieRepoistories: Get.find());
    final getPopularUsecase = GetPopularUsecase(movieRepoistories: Get.find());
    final getUpcomingUsecase =
        GetUpcommingUsecase(movieRepoistories: Get.find());
    final getNowPlayingUsecase =
        GetNowPlayingUsecase(movieRepoistories: Get.find());

    final results = await Future.wait([
      getPopularUsecase.call(NoParm()),
      getTrendingUsecase.call(NoParm()),
      getUpcomingUsecase.call(NoParm()),
      getNowPlayingUsecase.call(NoParm()),
    ]);

    allMovies.clear();
    results[0].fold((error) {
      print('Error fetching popular movies: $error');
    }, (movies) {
      popularMovies.value = movies;
      allMovies.addAll(popularMovies);
    });

    results[1].fold((error) {
      print('Error fetching trending movies: $error');
    }, (movies) {
      trendingMovies.value = movies;
      allMovies.addAll(trendingMovies);
    });

    results[2].fold((error) {
      print('Error fetching upcoming movies: $error');
    }, (movies) {
      upcomingMovies.value = movies;
      allMovies.addAll(upcomingMovies);
    });

    results[3].fold((error) {
      print('Error fetching now-playing movies: $error');
    }, (movies) {
      nowPlayingMovies.value = movies;
      allMovies.addAll(nowPlayingMovies);
    });

    isMovieLoading(false);
    selectedMovies = allMovies;
  }

  Future<void> fetchMovieDetails(int id) async {
    isMovieDetailsLoading(true);
    final getMovieDetailsUsecase =
        GetMovieDetailsUsecase(movieRepoistories: Get.find());

    var result = await getMovieDetailsUsecase.call(id);
    result.fold((error) {
      print('Error fetching popular movies: $error');
    }, (details) {
      movieDetails.value = details;
      print(movieDetails.value.title);
    });

    isMovieDetailsLoading(false);
  }

  void changeMovieTab(int selectedTabIndex) {
    isMovieLoading(true);
    if (selectedTabIndex == 0) {
      selectedMovies = allMovies;
    } else if (selectedTabIndex == 1) {
      selectedMovies = trendingMovies;
    } else if (selectedTabIndex == 2) {
      selectedMovies = popularMovies;
    } else if (selectedTabIndex == 3) {
      selectedMovies = upcomingMovies;
    } else if (selectedTabIndex == 4) {
      selectedMovies = nowPlayingMovies;
    }
    isMovieLoading(false);
  }

  void filteredMovies() {
    print(searchTextController.value.text);
    print(allMovies.length);

    // Filter the movies based on the search text and update selectedMovies
    selectedMovies.value = allMovies
        .where((movie) => movie.title
            .toLowerCase()
            .contains(searchTextController.value.text.toLowerCase()))
        .toList();

    // Debug prints to check the filtered result
    print("Filtered movies count: ${selectedMovies.length}");
  }

  @override
  void onInit() {
    fetchAllMovies();

    super.onInit();
  }
}
