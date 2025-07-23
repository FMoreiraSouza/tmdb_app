import 'package:flutter/foundation.dart';
import 'package:tmdb_app/data/models/movie_model.dart';
import 'package:tmdb_app/features/popular_movies/usecases/get_popular_movies_usecase.dart';

class PopularMoviesController extends ChangeNotifier {
  final GetPopularMoviesUsecase _getPopularMovies;

  PopularMoviesController(this._getPopularMovies);

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
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
