import 'package:flutter/material.dart';
import 'package:tmdb_app/core/config/app_page_config.dart';
import 'package:tmdb_app/features/popular_movies/di/popular_movies_di.dart';
import 'package:tmdb_app/features/search_movies/di/search_movies_di.dart';
import 'package:tmdb_app/routes/app_routes.dart';

class AppRouteManager {
  static AppRouteManager? _instance;

  AppRouteManager._() {
    addPage(AppPage(route: AppRoutes.popularMovies, pageDependency: PopularMoviesDI()));
    addPage(AppPage(route: AppRoutes.searchMovies, pageDependency: SearchMoviesDI()));
  }

  static AppRouteManager get instance {
    _instance ??= AppRouteManager._();
    return _instance!;
  }

  Map<String, StatefulWidget Function(dynamic)> appPages = {};

  Map<String, StatefulWidget Function(dynamic)> getPages() => appPages;

  void addPage(AppPage appPage) {
    appPages[appPage.route] = (context) => appPage.pageDependency.getPage();
  }
}
