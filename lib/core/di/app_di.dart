import 'package:get_it/get_it.dart';
import 'package:tmdb_app/core/di/dio_di_manager.dart';
import 'package:tmdb_app/data/repositories/implementation/movie_repository_impl.dart';
import 'package:tmdb_app/features/popular_movies/controllers/popular_movies_controller.dart';
import 'package:tmdb_app/features/popular_movies/usecases/get_movies_details_usecase.dart';
import 'package:tmdb_app/features/popular_movies/usecases/get_popular_movies_usecase.dart';
import 'package:tmdb_app/features/search_movies/controllers/search_movies_controller.dart';
import 'package:tmdb_app/features/popular_movies/usecases/search_movies_usecase.dart';

class AppDI {
  static void init() {
    final getIt = GetIt.instance;

    if (!getIt.isRegistered<MovieRepositoryImpl>()) {
      getIt.registerSingleton<MovieRepositoryImpl>(MovieRepositoryImpl(DioDiManager.getDio()));
    }

    if (!getIt.isRegistered<PopularMoviesController>()) {
      getIt.registerSingleton<PopularMoviesController>(
        PopularMoviesController(
          GetPopularMoviesUsecase(getIt.get<MovieRepositoryImpl>()),
          GetMovieDetailsUsecase(getIt.get<MovieRepositoryImpl>()),
        ),
      );
    }

    if (!getIt.isRegistered<SearchMoviesController>()) {
      getIt.registerSingleton<SearchMoviesController>(
        SearchMoviesController(SearchMoviesUsecase(getIt.get<MovieRepositoryImpl>())),
      );
    }
  }
}
