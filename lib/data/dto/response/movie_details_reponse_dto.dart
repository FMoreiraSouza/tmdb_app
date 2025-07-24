import 'package:tmdb_app/data/models/movie_model.dart';

class MovieDetailsResponseDTO {
  final MovieModel movie;

  MovieDetailsResponseDTO({required this.movie});

  factory MovieDetailsResponseDTO.fromJson(Map<String, dynamic> json) {
    return MovieDetailsResponseDTO(movie: MovieModel.fromJson(json));
  }
}
