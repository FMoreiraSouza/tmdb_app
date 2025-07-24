import 'package:flutter/material.dart';
import 'package:tmdb_app/core/utils/reponsivity_utils.dart';
import 'package:tmdb_app/core/enums/widget_states.dart';
import 'package:tmdb_app/features/home/ui/widgets/movie_item_widget.dart';
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
  });

  @override
  Widget build(BuildContext context) {
    final orientation = ResponsivityUtils(context);
    return StateHandlerWidget(
      state: state,
      loadingMessage: loadingMessage,
      emptyMessage: emptyMessage,
      errorMessage: errorMessage,
      onRetry: onRetry,
      orientation: orientation,
      successWidget: ListView.builder(
        physics: physics,
        shrinkWrap: shrinkWrap,
        padding: orientation.responsivePadding(
          horizontalPercentage: horizontalPadding ?? 0.0,
          verticalPercentage: verticalPadding ?? 0.0,
        ),
        itemCount: movies.length,
        itemBuilder: (context, index) {
          return MovieItemWidget(
            movie: movies[index],
            orientation: orientation,
            showDuration: showDuration,
            showRating: showRating,
            showDivider: showDivider,
          );
        },
      ),
    );
  }
}
