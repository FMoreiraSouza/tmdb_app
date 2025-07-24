import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:tmdb_app/core/enums/widget_states.dart';
import 'package:tmdb_app/core/network/failure.dart';
import 'package:tmdb_app/data/models/movie_model.dart';
import 'package:tmdb_app/features/home/usecases/search_movies_usecase.dart';

class SearchMoviesController extends ChangeNotifier {
  final SearchMoviesUsecase _searchMoviesUsecase;
  Timer? _debounce;

  SearchMoviesController(this._searchMoviesUsecase);

  List<MovieModel> _movies = [];
  bool _isLoading = false;
  String _query = '';
  final WidgetStates _state = WidgetStates(currentState: WidgetStates.successState);

  List<MovieModel> get movies => _movies;
  bool get isLoading => _isLoading;
  int get state => _state.currentState;

  void setQuery(String query) {
    final trimmedQuery = query.trim();
    if (trimmedQuery == _query) return;

    _query = trimmedQuery;
    _debounce?.cancel();

    if (_query.isEmpty) {
      _movies = [];
      _isLoading = false;
      _updateState(WidgetStates.successState);
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
    _updateState(WidgetStates.loadingState);
    notifyListeners();

    try {
      final response = await _searchMoviesUsecase(_query);
      _movies = response.movies;
      if (_movies.isEmpty) {
        _updateState(WidgetStates.emptyState);
      } else {
        _updateState(WidgetStates.successState);
      }
    } catch (e) {
      _checkErrorState(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _checkErrorState(dynamic error) {
    switch (error.runtimeType) {
      case const (ConnectionException):
        _updateState(WidgetStates.noConnection);
        break;
      default:
        _updateState(WidgetStates.errorState);
    }
  }

  void _updateState(int newState) {
    _state.currentState = newState;
    notifyListeners();
  }

  void reset() {
    _query = '';
    _movies = [];
    _isLoading = false;
    _updateState(WidgetStates.successState);
    _debounce?.cancel();
    notifyListeners();
  }
}
