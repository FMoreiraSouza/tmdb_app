import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/popular_movies/controllers/popular_movies_controller.dart';
import 'package:tmdb_app/features/popular_movies/ui/pages/popular_movies_page.dart';

class PopularMoviesDI {
  StatefulWidget getPage() {
    return PopularMoviesPage(controller: GetIt.instance.get<PopularMoviesController>());
  }
}
