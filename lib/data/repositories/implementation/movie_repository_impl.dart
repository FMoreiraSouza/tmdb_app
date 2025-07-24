import 'package:tmdb_app/core/constants/api_constants.dart';
import 'package:tmdb_app/core/network/dio_client.dart';
import 'package:tmdb_app/core/network/driver/connectivity_driver.dart';
import 'package:tmdb_app/core/network/failure.dart';
import 'package:tmdb_app/data/dto/response/movie_response_dto.dart';
import 'package:tmdb_app/data/dto/response/movie_details_reponse_dto.dart';
import 'package:tmdb_app/data/repositories/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final DioClient _dioClient;
  final ConnectivityDriver _connectivityDriver;

  MovieRepositoryImpl(this._dioClient, this._connectivityDriver);

  Future<void> _checkConnectivity() async {
    final isOnline = await _connectivityDriver.isOnline();
    if (!isOnline) {
      throw ConnectionException(
        'Sem conexão com a internet. Verifique sua rede e tente novamente.',
      );
    }
  }

  @override
  Future<MovieResponseDTO> getPopularMovies() async {
    await _checkConnectivity();
    try {
      final response = await _dioClient.dio.get(
        'movie/popular',
        queryParameters: {'api_key': ApiConstants.apiKey},
      );
      return MovieResponseDTO.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieResponseDTO> searchMovies(String query) async {
    await _checkConnectivity();
    try {
      final response = await _dioClient.dio.get(
        'search/movie',
        queryParameters: {'api_key': ApiConstants.apiKey, 'query': query},
      );
      return MovieResponseDTO.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieDetailsResponseDTO> getMovieDetails(int movieId) async {
    await _checkConnectivity();
    try {
      final response = await _dioClient.dio.get(
        'movie/$movieId',
        queryParameters: {'api_key': ApiConstants.apiKey},
      );
      return MovieDetailsResponseDTO.fromJson(response.data);
    } catch (e) {
      rethrow;
    }
  }
}
