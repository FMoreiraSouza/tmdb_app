import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:tmdb_app/features/search_movies/controllers/search_movies_controller.dart';
import 'package:tmdb_app/features/search_movies/ui/pages/search_movies_page.dart';

class SearchMoviesDI {
  StatefulWidget getPage() {
    return SearchMoviesPage(controller: GetIt.instance.get<SearchMoviesController>());
  }
}
