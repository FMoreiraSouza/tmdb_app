import 'package:tmdb_app/data/dto/response/movie_response_dto.dart';

abstract class MovieRepository {
  Future<MovieResponseDto> getPopularMovies();
  Future<MovieResponseDto> searchMovies(String query);
}
