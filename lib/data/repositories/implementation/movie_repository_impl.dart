import 'package:tmdb_app/core/constants/api_constants.dart';
import 'package:tmdb_app/core/network/dio_client.dart';
import 'package:tmdb_app/data/dto/response/movie_response_dto.dart';
import 'package:tmdb_app/data/models/movie_model.dart';
import 'package:tmdb_app/data/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final DioClient _dioClient;

  MovieRepositoryImpl(this._dioClient);

  @override
  Future<MovieResponseDto> getPopularMovies() async {
    try {
      final response = await _dioClient.dio.get(
        'movie/popular',
        queryParameters: {'api_key': ApiConstants.apiKey},
      );
      return MovieResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch popular movies: $e');
    }
  }

  @override
  Future<MovieResponseDto> searchMovies(String query) async {
    try {
      final response = await _dioClient.dio.get(
        'search/movie',
        queryParameters: {'api_key': ApiConstants.apiKey, 'query': query},
      );
      return MovieResponseDto.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to search movies: $e');
    }
  }

  @override
  Future<MovieModel> getMovieDetails(int movieId) async {
    try {
      final response = await _dioClient.dio.get(
        'movie/$movieId',
        queryParameters: {'api_key': ApiConstants.apiKey},
      );
      return MovieModel.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to fetch movie details: $e');
    }
  }
}
