import 'package:tmdb_app/data/dto/response/movie_response_dto.dart';
import 'package:tmdb_app/data/repositories/movie_repository.dart';

class GetPopularMoviesUsecase {
  final MovieRepository repository;

  GetPopularMoviesUsecase(this.repository);

  Future<MovieResponseDto> call() async {
    return await repository.getPopularMovies();
  }
}
