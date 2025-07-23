import 'package:flutter/foundation.dart';
import 'package:tmdb_app/data/models/movie_model.dart';
import 'package:tmdb_app/features/home/usecases/get_movies_details_usecase.dart';
import 'package:tmdb_app/features/home/usecases/get_popular_movies_usecase.dart';
import 'package:dio/dio.dart';

class PopularMoviesController extends ChangeNotifier {
  final GetPopularMoviesUsecase _getPopularMovies;
  final GetMovieDetailsUsecase _getMovieDetails;

  PopularMoviesController(this._getPopularMovies, this._getMovieDetails);

  List<MovieModel> _movies = [];
  bool _isLoading = false;
  String? _errorMessage;
  bool _isDataLoaded = false;

  List<MovieModel> get movies => _movies;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPopularMovies({bool forceRefresh = false}) async {
    if (_isDataLoaded && !forceRefresh) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _getPopularMovies();
      _movies = response.movies;

      // Busca detalhes (runtime) para cada filme
      for (var i = 0; i < _movies.length; i++) {
        final movie = _movies[i];
        final details = await _getMovieDetails(movie.id);
        _movies[i] = MovieModel(
          id: movie.id,
          title: movie.title,
          posterPath: movie.posterPath,
          voteAverage: movie.voteAverage,
          popularity: movie.popularity,
          runtime: details.runtime,
        );
      }
      _isDataLoaded = true;
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 429) {
          _errorMessage = 'Limite de requisições atingido. Tente novamente mais tarde.';
        } else if (e.response?.statusCode != null && e.response!.statusCode! >= 500) {
          _errorMessage = 'Serviço indisponível. Tente novamente mais tarde.';
        } else {
          _errorMessage = 'Erro ao carregar filmes: ${e.message}';
        }
      } else {
        _errorMessage = e.toString();
      }
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
