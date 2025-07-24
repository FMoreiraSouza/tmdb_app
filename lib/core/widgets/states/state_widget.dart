import 'package:flutter/material.dart';
import 'package:tmdb_app/core/enums/widget_states.dart';
import 'package:tmdb_app/core/utils/reponsivity_utils.dart';

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
    final orientation = ResponsivityUtils(context);

    String defaultMessage;
    IconData defaultIcon;
    Color defaultIconColor;

    switch (state.currentState) {
      case WidgetStates.noConnection:
        defaultMessage = 'Sem conexão com a internet';
        defaultIcon = Icons.signal_wifi_off;
        defaultIconColor = Theme.of(context).textTheme.bodyMedium!.color!; // Usa bodyMedium.color
        break;
      case WidgetStates.emptyState:
        defaultMessage = 'Nenhum filme encontrado';
        defaultIcon = Icons.search_off;
        defaultIconColor = Theme.of(context).textTheme.bodyMedium!.color!; // Usa bodyMedium.color
        break;
      case WidgetStates.errorState:
      default:
        defaultMessage = 'Erro ao carregar dados';
        defaultIcon = Icons.error_outline;
        defaultIconColor = Theme.of(context).textTheme.bodyMedium!.color!; // Usa bodyMedium.color
        break;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? defaultIcon,
            color: iconColor ?? defaultIconColor,
            size: orientation.responsiveSize(0.1, 40),
          ),
          SizedBox(height: orientation.shortestSide * 0.02),
          Text(
            message ?? defaultMessage,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(fontSize: orientation.responsiveSize(0.04, 16)),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            SizedBox(height: orientation.shortestSide * 0.04),
            ElevatedButton(
              onPressed: onRetry,
              style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                padding: WidgetStateProperty.all(
                  orientation.responsivePadding(
                    horizontalPercentage: 0.04,
                    verticalPercentage: 0.02,
                  ),
                ),
              ),
              child: Text(
                'Tentar novamente',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(fontSize: orientation.responsiveSize(0.04, 16)),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
