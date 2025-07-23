import 'package:get_it/get_it.dart';
import 'package:tmdb_app/core/network/dio_client.dart';
import 'package:tmdb_app/data/repositories/implementation/movie_repository_impl.dart';
import 'package:tmdb_app/data/repositories/movie_repository.dart';
import 'package:tmdb_app/features/popular_movies/controllers/popular_movies_controller.dart';
import 'package:tmdb_app/features/popular_movies/usecases/get_popular_movies_usecase.dart';
import 'package:tmdb_app/features/popular_movies/usecases/search_movies_usecase.dart';
import 'package:tmdb_app/features/search_movies/controllers/search_movies_controller.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerSingleton<DioClient>(DioClient());
  getIt.registerSingleton<MovieRepository>(MovieRepositoryImpl(getIt<DioClient>()));
  getIt.registerSingleton<GetPopularMoviesUsecase>(
    GetPopularMoviesUsecase(getIt<MovieRepository>()),
  );
  getIt.registerSingleton<SearchMoviesUsecase>(SearchMoviesUsecase(getIt<MovieRepository>()));
  getIt.registerSingleton<PopularMoviesController>(
    PopularMoviesController(getIt<GetPopularMoviesUsecase>()),
  );
  getIt.registerSingleton<SearchMoviesController>(
    SearchMoviesController(getIt<SearchMoviesUsecase>()),
  );
}
