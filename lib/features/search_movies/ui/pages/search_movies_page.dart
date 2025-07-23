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
  void initState() {
    super.initState();
    widget.controller.reset();
    _searchController.clear();
    _searchController.addListener(() {
      widget.controller.setQuery(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(title: const Text('Buscar Filmes')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Digite o nome do filme...',
                  hintStyle: const TextStyle(color: Colors.grey),
                  filled: true,
                  fillColor: Colors.white12,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.search, color: Colors.grey),
                ),
                style: const TextStyle(color: Colors.white),
                textInputAction: TextInputAction.search,
                onSubmitted: (_) {
                  FocusScope.of(context).unfocus();
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
                            onPressed: () => widget.controller.setQuery(_searchController.text),
                            child: const Text('Tentar novamente'),
                          ),
                        ],
                      ),
                    );
                  }
                  if (widget.controller.movies.isEmpty && _searchController.text.isNotEmpty) {
                    return const Center(
                      child: Text('Nenhum filme encontrado', style: TextStyle(color: Colors.white)),
                    );
                  }
                  if (widget.controller.movies.isEmpty) {
                    return const Center(
                      child: Text(
                        'Digite para buscar filmes',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.all(8.0),
                    itemCount: widget.controller.movies.length,
                    itemBuilder: (context, index) {
                      final movie = widget.controller.movies[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 60,
                              height: 90,
                              child: movie.posterPath != null
                                  ? CachedNetworkImage(
                                      imageUrl: '${ApiConstants.imageBaseUrl}${movie.posterPath}',
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) => const Center(
                                        child: SpinKitCircle(color: Colors.blue, size: 30.0),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error, color: Colors.white, size: 40),
                                    )
                                  : const Icon(Icons.movie, size: 60, color: Colors.white),
                            ),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Text(
                                movie.title,
                                style: const TextStyle(color: Colors.white, fontSize: 16),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
