import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:tmdb_app/data/models/movie_model.dart';
import 'package:tmdb_app/features/home/usecases/search_movies_usecase.dart';
import 'package:dio/dio.dart';

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
      if (e is DioException) {
        if (e.response?.statusCode == 429) {
          _errorMessage = 'Limite de requisições atingido. Tente novamente mais tarde.';
        } else if (e.response?.statusCode != null && e.response!.statusCode! >= 500) {
          _errorMessage = 'Serviço indisponível. Tente novamente mais tarde.';
        } else {
          _errorMessage = 'Erro ao buscar filmes: ${e.message}';
        }
      } else {
        _errorMessage = e.toString();
      }
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
