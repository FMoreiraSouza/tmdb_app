import 'package:flutter/material.dart';
import 'package:tmdb_app/core/enums/widget_states.dart';
import 'package:tmdb_app/core/utils/reponsivity_utils.dart';
import 'package:tmdb_app/core/constants/app_constants.dart';

class StateWidget extends StatelessWidget {
  final WidgetStates state;
  final String? message;
  final VoidCallback? onRetry;
  final IconData? icon;
  final Color? iconColor;

  const StateWidget({
    super.key,
    required this.state,
    this.message,
    this.onRetry,
    this.icon,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final responsivity = ResponsivityUtils(context);

    String defaultMessage;
    IconData defaultIcon;
    Color defaultIconColor;

    switch (state.currentState) {
      case WidgetStates.noConnection:
        defaultMessage = 'Sem conexão com a internet';
        defaultIcon = Icons.signal_wifi_off;
        defaultIconColor = AppConstants.getDefaultIconColor(context);
        break;
      case WidgetStates.emptyState:
        defaultMessage = 'Nenhum filme encontrado';
        defaultIcon = Icons.search_off;
        defaultIconColor = AppConstants.getDefaultIconColor(context);
        break;
      case WidgetStates.errorState:
      default:
        defaultMessage = 'Erro ao carregar dados';
        defaultIcon = Icons.error_outline;
        defaultIconColor = AppConstants.getDefaultIconColor(context);
        break;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? defaultIcon,
            color: iconColor ?? defaultIconColor,
            size: responsivity.responsiveSize(
              AppConstants.iconSizePercentage,
              AppConstants.iconSizeBase,
            ),
          ),
          SizedBox(height: responsivity.defaultSpacing()),
          Text(
            message ?? defaultMessage,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: responsivity.responsiveSize(
                AppConstants.textSizePercentage,
                AppConstants.textSizeBase,
              ),
            ),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            SizedBox(height: responsivity.defaultSpacing(multiplier: 2.0)),
            ElevatedButton(
              onPressed: onRetry,
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                padding: WidgetStateProperty.all(
                  responsivity.responsivePadding(
                    horizontalPercentage: AppConstants.searchHorizontalPaddingPercentage,
                    verticalPercentage: AppConstants.searchVerticalPaddingPercentage,
                  ),
                ),
              ),
              child: Text(
                'Tentar novamente',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: responsivity.responsiveSize(
                    AppConstants.textSizePercentage,
                    AppConstants.textSizeBase,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
