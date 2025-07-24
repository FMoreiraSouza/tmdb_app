import 'package:flutter/material.dart';
import 'package:tmdb_app/core/enums/widget_states.dart';

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
    String defaultMessage;
    IconData defaultIcon;
    Color defaultIconColor;

    switch (state.currentState) {
      case WidgetStates.noConnection:
        defaultMessage = 'Sem conexão com a internet';
        defaultIcon = Icons.signal_wifi_off;
        defaultIconColor = Colors.red;
        break;
      case WidgetStates.emptyState:
        defaultMessage = 'Nenhum filme encontrado';
        defaultIcon = Icons.search_off;
        defaultIconColor = Colors.grey;
        break;
      case WidgetStates.errorState:
      default:
        defaultMessage = 'Erro ao carregar dados';
        defaultIcon = Icons.error_outline;
        defaultIconColor = Colors.red;
        break;
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon ?? defaultIcon, color: iconColor ?? defaultIconColor, size: 40),
          const SizedBox(height: 8),
          Text(
            message ?? defaultMessage,
            style: const TextStyle(color: Colors.white, fontSize: 16),
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color(0xFF2B64DF),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Tentar novamente'),
            ),
          ],
        ],
      ),
    );
  }
}
