import 'package:flutter/material.dart';
import 'package:tmdb_app/core/theme/app_theme.dart';
import 'package:tmdb_app/features/popular_movies/controllers/popular_movies_controller.dart';
import 'package:tmdb_app/features/popular_movies/di/popular_movies_di.dart';
import 'package:tmdb_app/features/popular_movies/ui/pages/popular_movies_page.dart';

void main() {
  setupDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB App',
      theme: appTheme(),
      home: PopularMoviesPage(controller: getIt<PopularMoviesController>()),
    );
  }
}
