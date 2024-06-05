// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:movie_zone/constants/theme.dart';
import 'package:movie_zone/controllers/movie-controller.dart';
import 'package:movie_zone/domain/entities/movie-entity.dart';
import 'package:movie_zone/presentation/pages/movie-details/movie-detail.dart';
import 'package:movie_zone/presentation/widgets/text.dart';
import 'package:movie_zone/utils/util.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../constants/apis.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final MovieController movieController = Get.find<MovieController>();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(top: 40),
        color: AppTheme.black,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            Header(size: size, controller: movieController),
            Tabs(tabController: _tabController),
            SliverToBoxAdapter(child: Util.box(size: 15.0)),
            MovieGrid(movieController: movieController),
          ],
        ),
      ),
    );
  }
}

class MovieGrid extends StatelessWidget {
  const MovieGrid({super.key, required this.movieController});

  final MovieController movieController;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Obx(() {
        if (movieController.isMovieLoading.isFalse) {
          return MasonryGridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: movieController.selectedMovies.length,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              final movieItem = movieController.selectedMovies[index];
              return MovieItem(movieItem: movieItem);
            },
          );
        } else {
          return const Center(
              child: CircularProgressIndicator(color: AppTheme.white));
        }
      }),
    );
  }
}

class MovieItem extends StatelessWidget {
  const MovieItem({super.key, required this.movieItem});

  final MovieEntity movieItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(() => MovieDetailPage(id: movieItem.id));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 170,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: CachedNetworkImage(
                  placeholder: (context, url) => const SizedBox(
                    height: 20.0,
                    width: 20.0,
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child:
                            CircularProgressIndicator(color: AppTheme.orange),
                      ),
                    ),
                  ),
                  fit: BoxFit.cover,
                  imageUrl:
                      "${ApiConstants.baseImageUrl}${movieItem.posterPath}",
                ),
              ),
            ),
            Util.box(size: 14.0),
            TextW(title: movieItem.title),
          ],
        ),
      ),
    );
  }
}

class Tabs extends StatelessWidget {
  const Tabs({super.key, required TabController tabController})
      : _tabController = tabController;

  final TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: AppTheme.black,
        child: TabBar(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          isScrollable: true,
          indicatorSize: TabBarIndicatorSize.label,
          controller: _tabController,
          onTap: Get.find<MovieController>().changeMovieTab,
          tabs: const [
            Tab(text: "All"),
            Tab(text: "Trending"),
            Tab(text: "Popular"),
            Tab(text: "Upcoming"),
            Tab(text: "Now Playing"),
          ],
          labelColor: AppTheme.orange,
          labelStyle: const TextStyle(fontSize: 13.0),
          unselectedLabelColor: Colors.white70,
          indicatorColor: AppTheme.orange,
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key, required this.size, required this.controller});

  final Size size;
  final MovieController controller;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: TextW(
              title: "Find Movies, TV series\nand more...",
              size: 22.0,
              weight: FontWeight.w400,
            ),
          ),
          Util.box(size: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SearchBox(size: size, controller: controller),
          ),
          Util.box(size: 15.0),
        ],
      ),
    );
  }
}

class SearchBox extends StatelessWidget {
  const SearchBox({super.key, required this.size, required this.controller});

  final Size size;
  final MovieController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: 50.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: const Color.fromARGB(31, 23, 26, 69),
      ),
      child: TextField(
        onChanged: (value) {
          if (value.isEmpty) {
            controller.selectedMovies.value = controller.allMovies;
          } else {
            controller.filteredMovies();
          }
        },
        controller: controller.searchTextController.value,
        style: const TextStyle(color: AppTheme.orange),
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.symmetric(vertical: 15),
          isDense: true,
          prefixIcon: Icon(
            Icons.search,
            color: AppTheme.white,
          ),
          labelStyle: TextStyle(color: AppTheme.orange),
          hintStyle: TextStyle(color: AppTheme.white),
          hintText: "Search...",
          border: InputBorder.none,
        ),
      ),
    );
  }
}
