import 'package:flutter/material.dart';
import 'package:tmdb_app/core/utils/reponsivity_utils.dart';
import 'package:tmdb_app/core/enums/widget_states.dart';
import 'package:tmdb_app/data/models/movie_model.dart';
import 'package:tmdb_app/features/home/ui/widgets/popular_movie/popular_movie_item_widget.dart';
import 'package:tmdb_app/features/home/ui/widgets/search_movie/search_movie_item_widget.dart';
import 'package:tmdb_app/features/home/ui/widgets/state_handler_widget.dart';

class MovieListWidget extends StatelessWidget {
  final List<dynamic> movies;
  final WidgetStates state;
  final String loadingMessage;
  final String emptyMessage;
  final String errorMessage;
  final VoidCallback? onRetry;
  final bool showDuration;
  final bool showRating;
  final bool showDivider;
  final ScrollPhysics? physics;
  final bool shrinkWrap;
  final double? verticalPadding;
  final double? horizontalPadding;
  final bool isPopularMovies;

  const MovieListWidget({
    super.key,
    required this.movies,
    required this.state,
    required this.loadingMessage,
    required this.emptyMessage,
    required this.errorMessage,
    this.onRetry,
    this.showDuration = false,
    this.showRating = false,
    this.showDivider = false,
    this.physics,
    this.shrinkWrap = false,
    this.horizontalPadding,
    this.verticalPadding,
    this.isPopularMovies = false,
  });

  @override
  Widget build(BuildContext context) {
    final responsivity = ResponsivityUtils(context);
    return StateHandlerWidget(
      state: state,
      loadingMessage: loadingMessage,
      emptyMessage: emptyMessage,
      errorMessage: errorMessage,
      onRetry: onRetry,
      responsivity: responsivity,
      successWidget: ListView.builder(
        physics: physics,
        shrinkWrap: shrinkWrap,
        padding: responsivity.responsivePadding(
          horizontalPercentage: horizontalPadding ?? 0.0,
          verticalPercentage: verticalPadding ?? 0.0,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return isPopularMovies
              ? PopularMovieItemWidget(movie: movie as MovieModel, responsivity: responsivity)
              : SearchMovieItemWidget(
                  movie: movie,
                  responsivity: responsivity,
                  showDuration: showDuration,
                  showRating: showRating,
                  showDivider: showDivider,
                );
        },
      ),
    );
  }
}
