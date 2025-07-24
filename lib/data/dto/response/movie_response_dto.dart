import 'package:tmdb_app/data/models/movie_model.dart';

class MovieResponseDTO {
  final List<MovieModel> movies;

  MovieResponseDTO({required this.movies});

  factory MovieResponseDTO.fromJson(Map<String, dynamic> json) {
    final List<dynamic> results = json['results'] ?? [];
    return MovieResponseDTO(movies: results.map((json) => MovieModel.fromJson(json)).toList());
  }
}
