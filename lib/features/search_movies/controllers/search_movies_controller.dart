import 'package:flutter/foundation.dart';
import 'package:tmdb_app/data/models/movie_model.dart';
import 'package:tmdb_app/features/popular_movies/usecases/search_movies_usecase.dart';

class SearchMoviesController extends ChangeNotifier {
  final SearchMoviesUsecase _searchMoviesUsecase;

  SearchMoviesController(this._searchMoviesUsecase);

  List<MovieModel> _movies = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<MovieModel> get movies => _movies;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> search(String query) async {
    if (query.isEmpty) {
      _movies = [];
      _errorMessage = null;
      notifyListeners();
      return;
    }

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _searchMoviesUsecase(query);
      _movies = response.movies;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
