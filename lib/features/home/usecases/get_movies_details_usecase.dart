import 'package:tmdb_app/data/models/movie_model.dart';
import 'package:tmdb_app/data/repositories/movie_repository.dart';

class GetMovieDetailsUsecase {
  final MovieRepository _movieRepository;

  GetMovieDetailsUsecase(this._movieRepository);

  Future<MovieModel> call(int movieId) async {
    final response = await _movieRepository.getMovieDetails(movieId);
    return response.movie;
  }
}
