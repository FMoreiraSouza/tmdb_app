import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_app/core/enums/widget_states.dart';
import 'package:tmdb_app/core/widgets/states/state_widget.dart';
import 'package:tmdb_app/core/utils/reponsivity_utils.dart';
import 'package:tmdb_app/core/constants/app_constants.dart';

class StateHandlerWidget extends StatelessWidget {
  final WidgetStates state;
  final String loadingMessage;
  final String emptyMessage;
  final String errorMessage;
  final VoidCallback? onRetry;
  final Widget successWidget;
  final ResponsivityUtils orientation;

  const StateHandlerWidget({
    super.key,
    required this.state,
    required this.loadingMessage,
    required this.emptyMessage,
    required this.errorMessage,
    this.onRetry,
    required this.successWidget,
    required this.orientation,
  });

  @override
  Widget build(BuildContext context) {
    switch (state.currentState) {
      case WidgetStates.loadingState:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SpinKitCircle(
                color: AppConstants.getDefaultButtonColor(context),
                size: orientation.responsiveSize(
                  AppConstants.iconSizePercentage,
                  AppConstants.iconSizeBase,
                ),
              ),
              SizedBox(
                height: orientation.shortestSide * AppConstants.loadingTextSpacingPercentage,
              ),
              Text(
                loadingMessage,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: orientation.responsiveSize(
                    AppConstants.textSizePercentage,
                    AppConstants.textSizeBase,
                  ),
                ),
              ),
            ],
          ),
        );
      case WidgetStates.noConnection:
        return StateWidget(
          state: WidgetStates(currentState: WidgetStates.noConnection),
          onRetry: onRetry,
        );
      case WidgetStates.emptyState:
        return StateWidget(
          state: WidgetStates(currentState: WidgetStates.emptyState),
          message: emptyMessage,
        );
      case WidgetStates.successState:
        return successWidget;
      default:
        return StateWidget(
          state: WidgetStates(currentState: WidgetStates.errorState),
          message: errorMessage,
          onRetry: onRetry,
        );
    }
  }
}
