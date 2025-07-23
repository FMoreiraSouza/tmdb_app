import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_app/core/constants/api_constants.dart';
import 'package:tmdb_app/features/popular_movies/controllers/popular_movies_controller.dart';

class PopularMoviesWidget extends StatefulWidget {
  final PopularMoviesController controller;

  const PopularMoviesWidget({super.key, required this.controller});

  @override
  State<PopularMoviesWidget> createState() => _PopularMoviesWidgetState();
}

class _PopularMoviesWidgetState extends State<PopularMoviesWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.fetchPopularMovies();
    });
  }

  String formatDuration(int? minutes) {
    if (minutes == null || minutes <= 0) return 'N/A';
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return '${hours}h${remainingMinutes}m';
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filmes Populares')),
      body: AnimatedBuilder(
        animation: widget.controller,
        builder: (context, _) {
          if (widget.controller.isLoading) {
            return const Center(child: SpinKitCircle(color: Colors.blue, size: 50.0));
          }
          if (widget.controller.errorMessage != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(widget.controller.errorMessage!, style: const TextStyle(color: Colors.red)),
                  ElevatedButton(
                    onPressed: () => widget.controller.fetchPopularMovies(forceRefresh: true),
                    child: const Text('Tentar novamente'),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: widget.controller.movies.length,
            itemBuilder: (context, index) {
              final movie = widget.controller.movies[index];
              return Card(
                child: ListTile(
                  leading: SizedBox(
                    width: 50,
                    height: 50,
                    child: movie.posterPath != null
                        ? CachedNetworkImage(
                            imageUrl: '${ApiConstants.imageBaseUrl}${movie.posterPath}',
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                const Center(child: SpinKitCircle(color: Colors.blue, size: 30.0)),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          )
                        : const Icon(Icons.movie, size: 50, color: Colors.white),
                  ),
                  title: Text(
                    movie.title,
                    style: const TextStyle(color: Colors.white),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Row(
                    children: [
                      const Icon(Icons.access_time, color: Colors.grey, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        formatDuration(movie.runtime),
                        style: const TextStyle(color: Colors.grey),
                      ),
                    ],
                  ),
                  trailing: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        (movie.voteAverage * 10).round().toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
