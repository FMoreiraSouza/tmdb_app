import 'package:flutter/foundation.dart';
import 'package:tmdb_app/core/enums/widget_states.dart';
import 'package:tmdb_app/core/network/failure.dart';
import 'package:tmdb_app/data/models/movie_model.dart';
import 'package:tmdb_app/features/home/usecases/get_movies_details_usecase.dart';
import 'package:tmdb_app/features/home/usecases/get_popular_movies_usecase.dart';

class PopularMoviesController extends ChangeNotifier {
  final GetPopularMoviesUsecase _getPopularMovies;
  final GetMovieDetailsUsecase _getMovieDetails;

  PopularMoviesController(this._getPopularMovies, this._getMovieDetails);

  List<MovieModel> _movies = [];
  bool _isLoading = false;
  bool _isDataLoaded = false;
  final WidgetStates _state = WidgetStates(currentState: WidgetStates.loadingState);

  List<MovieModel> get movies => _movies;
  bool get isLoading => _isLoading;
  int get state => _state.currentState;

  Future<void> fetchPopularMovies({bool forceRefresh = false}) async {
    if (_isDataLoaded && !forceRefresh) return;

    _isLoading = true;
    _updateState(WidgetStates.loadingState);
    notifyListeners();

    try {
      final response = await _getPopularMovies();
      _movies = response.movies;

      if (_movies.isEmpty) {
        _isDataLoaded = true;
        _updateState(WidgetStates.emptyState);
      } else {
        for (var i = 0; i < _movies.length; i++) {
          try {
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
          } catch (e) {
            _movies[i] = MovieModel(
              id: _movies[i].id,
              title: _movies[i].title,
              posterPath: _movies[i].posterPath,
              voteAverage: _movies[i].voteAverage,
              popularity: _movies[i].popularity,
              runtime: null,
            );
          }
        }
        _isDataLoaded = true;
        _updateState(WidgetStates.successState);
      }
    } catch (e) {
      _isDataLoaded = false;
      _handleError(e);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _handleError(dynamic error) {
    if (error is ConnectionException) {
      _updateState(WidgetStates.noConnection);
    } else {
      _updateState(WidgetStates.errorState);
    }
  }

  void _updateState(int newState) {
    _state.currentState = newState;
    notifyListeners();
  }

  void reset() {
    _movies = [];
    _isDataLoaded = false;
    _isLoading = false;
    _updateState(WidgetStates.loadingState);
    notifyListeners();
  }
}
