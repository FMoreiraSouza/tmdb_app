import 'package:get_it/get_it.dart';
import 'package:tmdb_app/core/di/dio_di_manager.dart';
import 'package:tmdb_app/core/network/driver/connectivity_driver.dart';
import 'package:tmdb_app/core/network/driver/implementation/connectivity_driver_impl.dart';
import 'package:tmdb_app/data/repositories/implementation/movie_repository_impl.dart';
import 'package:tmdb_app/features/home/controllers/popular_movies_controller.dart';
import 'package:tmdb_app/features/home/usecases/get_movies_details_usecase.dart';
import 'package:tmdb_app/features/home/usecases/get_popular_movies_usecase.dart';
import 'package:tmdb_app/features/home/controllers/search_movies_controller.dart';
import 'package:tmdb_app/features/home/usecases/search_movies_usecase.dart';

class AppDI {
  static final GetIt _getIt = GetIt.instance;

  static GetIt get instance => _getIt;

  static void init() {
    _getIt.registerSingleton<ConnectivityDriver>(ConnectivityDriverImpl());
    _getIt.registerSingleton<MovieRepositoryImpl>(
      MovieRepositoryImpl(DioDIManager.getDio(), _getIt.get<ConnectivityDriver>()),
    );
    _getIt.registerSingleton<PopularMoviesController>(
      PopularMoviesController(
        GetPopularMoviesUsecase(_getIt.get<MovieRepositoryImpl>()),
        GetMovieDetailsUsecase(_getIt.get<MovieRepositoryImpl>()),
      ),
    );
    _getIt.registerSingleton<SearchMoviesController>(
      SearchMoviesController(SearchMoviesUsecase(_getIt.get<MovieRepositoryImpl>())),
    );
  }
}
