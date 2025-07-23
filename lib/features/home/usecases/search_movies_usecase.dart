import 'package:tmdb_app/data/dto/response/movie_response_dto.dart';
import 'package:tmdb_app/data/repositories/movie_repository.dart';

class SearchMoviesUsecase {
  final MovieRepository repository;

  SearchMoviesUsecase(this.repository);

  Future<MovieResponseDto> call(String query) async {
    return await repository.searchMovies(query);
  }
}
