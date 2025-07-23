import 'package:tmdb_app/data/models/movie_model.dart';

class MovieResponseDto {
  final List<MovieModel> movies;

  MovieResponseDto({required this.movies});

  factory MovieResponseDto.fromJson(Map<String, dynamic> json) {
    final List<dynamic> results = json['results'] ?? [];
    return MovieResponseDto(movies: results.map((json) => MovieModel.fromJson(json)).toList());
  }
}
