import 'package:tmdb_app/core/constants/api_constants.dart';
import 'package:tmdb_app/core/network/dio_client.dart';
import 'package:tmdb_app/core/network/driver/connectivity_driver.dart';
import 'package:tmdb_app/data/dto/response/movie_response_dto.dart';
import 'package:tmdb_app/data/models/movie_model.dart';
import 'package:tmdb_app/data/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final DioClient _dioClient;
  final ConnectivityDriver _connectivityDriver;

  MovieRepositoryImpl(this._dioClient, this._connectivityDriver);

  Future<void> _checkConnectivity() async {
    final isOnline = await _connectivityDriver.isOnline();
    if (!isOnline) {
      throw Exception('Sem conexão com a internet. Verifique sua rede e tente novamente.');
    }
  }

  @override
  Future<MovieResponseDto> getPopularMovies() async {
    await _checkConnectivity();
    try {
      final response = await _dioClient.dio.get(
        'movie/popular',
        queryParameters: {'api_key': ApiConstants.apiKey},
      );
      return MovieResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieResponseDto> searchMovies(String query) async {
    await _checkConnectivity();
    try {
      final response = await _dioClient.dio.get(
        'search/movie',
        queryParameters: {'api_key': ApiConstants.apiKey, 'query': query},
      );
      return MovieResponseDto.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieModel> getMovieDetails(int movieId) async {
    await _checkConnectivity();
    try {
      final response = await _dioClient.dio.get(
        'movie/$movieId',
        queryParameters: {'api_key': ApiConstants.apiKey},
      );
      return MovieModel.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
