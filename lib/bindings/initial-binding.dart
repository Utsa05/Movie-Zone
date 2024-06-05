import 'package:http/http.dart';
import 'package:get/get.dart';
import 'package:movie_zone/controllers/common-controller.dart';
import 'package:movie_zone/controllers/movie-controller.dart';
import 'package:movie_zone/data/core/api-client.dart';
import 'package:movie_zone/data/data-sources/movie-datasource.dart';
import 'package:get/get.dart';
import 'package:movie_zone/data/repositories/movie-repository-impl.dart';
import 'package:movie_zone/domain/entities/no-param.dart';
import 'package:movie_zone/domain/repositories/movie-repositories.dart';
import 'package:movie_zone/domain/usecases/get-trending-movie.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(Client());
    Get.put(ApiClient(client: Get.find()));

    Get.put<MovieDatasource>(MovieDatasourceImpl(apiClient: Get.find()));
    Get.put<MovieRepoistories>(
        MovieRepoistoriesImpl(movieDatasource: Get.find()));
    Get.put(NoParm());
    Get.put(GetTrendingUsecase(movieRepoistories: Get.find()));

    //!controller

    Get.put(CommonController());
    Get.put(MovieController());
  }
}
