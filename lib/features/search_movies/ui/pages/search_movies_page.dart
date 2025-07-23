import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_app/core/constants/api_constants.dart';
import 'package:tmdb_app/features/search_movies/controllers/search_movies_controller.dart';

class SearchMoviesPage extends StatefulWidget {
  final SearchMoviesController controller;

  const SearchMoviesPage({super.key, required this.controller});

  @override
  State<SearchMoviesPage> createState() => _SearchMoviesPageState();
}

class _SearchMoviesPageState extends State<SearchMoviesPage> {
  final _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Buscar Filmes')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Digite o nome do filme',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    widget.controller.search(_searchController.text);
                  },
                ),
              ),
              onSubmitted: (value) {
                widget.controller.search(value);
              },
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
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
                        Text(
                          widget.controller.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            widget.controller.search(_searchController.text);
                          },
                          child: const Text('Tentar novamente'),
                        ),
                      ],
                    ),
                  );
                }

                if (widget.controller.movies.isEmpty && _searchController.text.isNotEmpty) {
                  return const Center(child: Text('Nenhum filme encontrado'));
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(8.0),
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
                                  placeholder: (context, url) => const Center(
                                    child: SpinKitCircle(color: Colors.blue, size: 30.0),
                                  ),
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
                        subtitle: Text(
                          // Duração não está no modelo, usando voteAverage como placeholder
                          'Nota: ${movie.voteAverage.toStringAsFixed(1)}',
                          style: const TextStyle(color: Colors.grey),
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
                              movie.voteAverage.toStringAsFixed(1),
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
          ),
        ],
      ),
    );
  }
}
