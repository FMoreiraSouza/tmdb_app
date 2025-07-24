import 'package:tmdb_app/data/dto/response/movie_response_dto.dart';
import 'package:tmdb_app/data/dto/response/movie_details_reponse_dto.dart';

abstract class MovieRepository {
  Future<MovieResponseDTO> getPopularMovies();
  Future<MovieResponseDTO> searchMovies(String query);
  Future<MovieDetailsResponseDTO> getMovieDetails(int movieId);
}
