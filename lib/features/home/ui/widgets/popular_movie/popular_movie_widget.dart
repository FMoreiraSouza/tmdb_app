import 'package:flutter/material.dart';
import 'package:tmdb_app/core/enums/widget_states.dart';
import 'package:tmdb_app/features/home/controllers/popular_movies_controller.dart';
import 'package:tmdb_app/features/home/ui/widgets/movie_list_widget.dart';

class PopularMovieWidget extends StatefulWidget {
  final PopularMoviesController controller;

  const PopularMovieWidget({super.key, required this.controller});

  @override
  State<PopularMovieWidget> createState() => _PopularMovieWidgetState();
}

class _PopularMovieWidgetState extends State<PopularMovieWidget>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.fetchPopularMovies();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Filmes Populares')),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: widget.controller,
          builder: (context, _) {
            return MovieListWidget(
              movies: widget.controller.movies,
              state: WidgetStates(currentState: widget.controller.state),
              loadingMessage: 'Carregando filmes populares',
              emptyMessage: 'Nenhum filme encontrado.',
              errorMessage: 'Erro ao carregar filmes',
              onRetry: () => widget.controller.fetchPopularMovies(forceRefresh: true),
              showDuration: true,
              showRating: true,
              isPopularMovies: true,
            );
          },
        ),
      ),
    );
  }
}
