import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:tmdb_app/data/models/movie_model.dart';
import 'package:tmdb_app/features/popular_movies/usecases/search_movies_usecase.dart';

class SearchMoviesController extends ChangeNotifier {
  final SearchMoviesUsecase _searchMoviesUsecase;
  Timer? _debounce;

  SearchMoviesController(this._searchMoviesUsecase);

  List<MovieModel> _movies = [];
  bool _isLoading = false;
  String? _errorMessage;
  String _query = '';

  List<MovieModel> get movies => _movies;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setQuery(String query) {
    final trimmedQuery = query.trim();
    if (trimmedQuery == _query) return;

    _query = trimmedQuery;
    _debounce?.cancel();

    if (_query.isEmpty) {
      _movies = [];
      _errorMessage = null;
      _isLoading = false;
      notifyListeners();
    } else {
      _debounce = Timer(const Duration(milliseconds: 500), () {
        searchMovies();
      });
    }
  }

  Future<void> searchMovies() async {
    if (_query.isEmpty) return;

    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      final response = await _searchMoviesUsecase(_query);
      _movies = response.movies;
    } catch (e) {
      _errorMessage = 'Erro ao buscar filmes: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _query = '';
    _movies = [];
    _errorMessage = null;
    _isLoading = false;
    _debounce?.cancel();
    notifyListeners();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}
