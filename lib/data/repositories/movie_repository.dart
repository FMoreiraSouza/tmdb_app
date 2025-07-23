import 'package:tmdb_app/data/dto/response/movie_response_dto.dart';
import 'package:tmdb_app/data/models/movie_model.dart';

abstract class MovieRepository {
  Future<MovieResponseDto> getPopularMovies();
  Future<MovieResponseDto> searchMovies(String query);
  Future<MovieModel> getMovieDetails(int movieId);
}
