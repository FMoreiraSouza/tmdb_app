import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_app/core/constants/api_constants.dart';
import 'package:tmdb_app/features/home/controllers/search_movies_controller.dart';

class SearchMoviesWidget extends StatefulWidget {
  final SearchMoviesController controller;

  const SearchMoviesWidget({super.key, required this.controller});

  @override
  State<SearchMoviesWidget> createState() => _SearchMoviesWidgetState();
}

class _SearchMoviesWidgetState extends State<SearchMoviesWidget> {
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
        appBar: AppBar(title: const Text('Busca'), automaticallyImplyLeading: false),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF292E34),
                  borderRadius: BorderRadius.circular(30.0),
                  border: Border.all(color: Colors.grey, width: 0.2),
                ),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Buscar filmes',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintStyle: const TextStyle(color: Colors.grey),
                    filled: false,
                    prefixIcon: const Icon(Icons.search, color: Colors.grey),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  ),
                  textInputAction: TextInputAction.search,
                  onSubmitted: (_) {
                    FocusScope.of(context).unfocus();
                  },
                ),
              ),
            ),
            Expanded(
              child: AnimatedBuilder(
                animation: widget.controller,
                builder: (context, _) {
                  if (widget.controller.isLoading) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SpinKitCircle(color: Colors.blue, size: 50.0),
                          SizedBox(height: 16),
                          Text(
                            'Buscando filmes...',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }
                  if (widget.controller.errorMessage != null) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.error_outline, color: Colors.red, size: 40),
                          const SizedBox(height: 8),
                          Text(
                            widget.controller.errorMessage!,
                            style: const TextStyle(color: Colors.red, fontSize: 16),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 16),
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
                      child: Text(
                        'Nenhum filme encontrado para esta busca.',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                        textAlign: TextAlign.center,
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
