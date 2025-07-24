import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_app/core/constants/api_constants.dart';
import 'package:tmdb_app/core/enums/widget_states.dart';
import 'package:tmdb_app/core/widgets/states/state_widget.dart';
import 'package:tmdb_app/core/utils/reponsivity_utils.dart';
import 'package:tmdb_app/features/home/controllers/popular_movies_controller.dart';

class PopularMoviesWidget extends StatefulWidget {
  final PopularMoviesController controller;

  const PopularMoviesWidget({super.key, required this.controller});

  @override
  State<PopularMoviesWidget> createState() => _PopularMoviesWidgetState();
}

class _PopularMoviesWidgetState extends State<PopularMoviesWidget>
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
    super.build(context);
    final orientation = ResponsivityUtils(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Filmes Populares')),
      body: SafeArea(
        child: AnimatedBuilder(
          animation: widget.controller,
          builder: (context, _) {
            switch (widget.controller.state) {
              case WidgetStates.loadingState:
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SpinKitCircle(
                        color: Theme.of(
                          context,
                        ).elevatedButtonTheme.style!.backgroundColor!.resolve({}),
                        size: orientation.responsiveSize(0.1, 50),
                      ),
                      SizedBox(height: orientation.shortestSide * 0.03),
                      Text(
                        'Carregando filmes populares',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontSize: orientation.responsiveSize(0.04, 16),
                        ),
                      ),
                    ],
                  ),
                );
              case WidgetStates.noConnection:
                return StateWidget(
                  state: WidgetStates(currentState: WidgetStates.noConnection),
                  onRetry: () => widget.controller.fetchPopularMovies(forceRefresh: true),
                );
              case WidgetStates.emptyState:
                return StateWidget(
                  state: WidgetStates(currentState: WidgetStates.emptyState),
                  message: 'Nenhum filme encontrado.',
                );
              case WidgetStates.successState:
                return ListView.builder(
                  padding: orientation.responsivePadding(horizontalPercentage: 0.03),
                  itemCount: widget.controller.movies.length,
                  itemBuilder: (context, index) {
                    final movie = widget.controller.movies[index];
                    return Card(
                      margin: orientation.responsiveMargin(
                        verticalPercentage: 0.015,
                        horizontalPercentage: 0.03,
                      ),
                      color: Theme.of(context).cardTheme.color, // Usa cardTheme.color
                      child: ListTile(
                        leading: SizedBox(
                          width: orientation.responsiveSize(0.12, 60),
                          height: orientation.responsiveSize(0.12, 60),
                          child: movie.posterPath != null
                              ? CachedNetworkImage(
                                  imageUrl: '${ApiConstants.imageBaseUrl}${movie.posterPath}',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) => Center(
                                    child: SpinKitCircle(
                                      color: Theme.of(
                                        context,
                                      ).elevatedButtonTheme.style!.backgroundColor!.resolve({}),
                                      size: orientation.responsiveSize(0.08, 30),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) => Icon(
                                    Icons.error,
                                    size: orientation.responsiveSize(0.1, 50),
                                    color: Theme.of(context).appBarTheme.iconTheme?.color,
                                  ),
                                )
                              : Icon(
                                  Icons.movie,
                                  size: orientation.responsiveSize(0.1, 50),
                                  color: Theme.of(context).appBarTheme.iconTheme?.color,
                                ),
                        ),
                        title: Text(
                          movie.title,
                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            fontSize: orientation.responsiveSize(0.035, 14),
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Row(
                          children: [
                            Icon(
                              Icons.access_time,
                              color: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.color, // Usa bodyMedium.color
                              size: orientation.responsiveSize(0.03, 12),
                            ),
                            SizedBox(width: orientation.shortestSide * 0.015),
                            Text(
                              formatDuration(movie.runtime),
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                fontSize: orientation.responsiveSize(0.03, 12),
                              ),
                            ),
                          ],
                        ),
                        trailing: Container(
                          width: orientation.responsiveSize(0.1, 40),
                          height: orientation.responsiveSize(0.1, 40),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).elevatedButtonTheme.style!.backgroundColor!.resolve({}),
                            borderRadius: orientation.responsiveBorderRadius(0.03),
                          ),
                          child: Center(
                            child: Text(
                              (movie.voteAverage * 10).round().toString(),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: orientation.responsiveSize(0.035, 14),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              default:
                return StateWidget(
                  state: WidgetStates(currentState: WidgetStates.errorState),
                  message: 'Erro ao carregar filmes',
                  onRetry: () => widget.controller.fetchPopularMovies(forceRefresh: true),
                );
            }
          },
        ),
      ),
    );
  }
}
