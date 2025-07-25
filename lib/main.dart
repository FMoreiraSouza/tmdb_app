import 'package:flutter/material.dart';
import 'package:tmdb_app/core/di/app_di.dart';
import 'package:tmdb_app/core/di/dio_di_manager.dart';
import 'package:tmdb_app/core/theme/app_theme.dart';
import 'package:tmdb_app/routes/app_route_manager.dart';
import 'package:tmdb_app/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  DioDIManager.registerApi();

  AppDI.init();

  runApp(const TMDBApp());
}

class TMDBApp extends StatelessWidget {
  const TMDBApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TMDB App',
      debugShowCheckedModeBanner: false,
      theme: appTheme(),
      initialRoute: AppRoutes.home,
      routes: AppRouteManager.instance.getPages(),
    );
  }
}
