import 'package:flutter/foundation.dart';
import 'package:tmdb_app/data/models/movie_model.dart';
import 'package:tmdb_app/features/popular_movies/usecases/get_movies_details_usecase.dart';
import 'package:tmdb_app/features/popular_movies/usecases/get_popular_movies_usecase.dart';

class PopularMoviesController extends ChangeNotifier {
  final GetPopularMoviesUsecase _getPopularMovies;
  final GetMovieDetailsUsecase _getMovieDetails;

  PopularMoviesController(this._getPopularMovies, this._getMovieDetails);

  List<MovieModel> _movies = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<MovieModel> get movies => _movies;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> fetchPopularMovies() async {
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
    } catch (e) {
      _errorMessage = 'Erro ao carregar filmes: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
