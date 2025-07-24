class WidgetStates {
  static const int loadingState = 0;
  static const int successState = 1;
  static const int errorState = 2;
  static const int noConnection = 3;
  static const int emptyState = 4;

  int currentState;

  WidgetStates({required this.currentState});
}
