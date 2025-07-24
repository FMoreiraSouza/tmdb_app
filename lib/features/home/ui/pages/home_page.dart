import 'package:flutter/material.dart';
import 'package:tmdb_app/core/di/app_di.dart';
import 'package:tmdb_app/features/home/controllers/popular_movies_controller.dart';
import 'package:tmdb_app/features/home/ui/widgets/popular_movies_widget.dart';
import 'package:tmdb_app/features/home/controllers/search_movies_controller.dart';
import 'package:tmdb_app/features/home/ui/widgets/search_movies_widget.dart';
import 'package:tmdb_app/core/utils/reponsivity_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    PopularMoviesWidget(
      key: const Key('popular_movies'),
      controller: AppDI.instance.get<PopularMoviesController>(),
    ),
    SearchMoviesWidget(
      key: const Key('search_movies'),
      controller: AppDI.instance.get<SearchMoviesController>(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final orientation = ResponsivityUtils(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: orientation.responsivePadding(
            horizontalPercentage: 0.03,
            verticalPercentage: 0.02,
          ),
          child: Stack(
            children: [
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: _pages[_currentIndex],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: orientation.shortestSide * 0.03,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: orientation.responsiveMargin(horizontalPercentage: 0.05),
                      padding: EdgeInsets.all(orientation.shortestSide * 0.015),
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardTheme.color, // Usa cardTheme.color
                        borderRadius: orientation.responsiveBorderRadius(0.02),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildSwitchButton(
                            path: 'assets/icons/home.png',
                            isActive: _currentIndex == 0,
                            onTap: () {
                              setState(() {
                                _currentIndex = 0;
                              });
                            },
                            orientation: orientation,
                          ),
                          SizedBox(width: orientation.shortestSide * 0.02),
                          _buildSwitchButton(
                            path: 'assets/icons/search.png',
                            isActive: _currentIndex == 1,
                            onTap: () {
                              setState(() {
                                _currentIndex = 1;
                              });
                            },
                            orientation: orientation,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSwitchButton({
    required String path,
    required bool isActive,
    required VoidCallback onTap,
    required ResponsivityUtils orientation,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: orientation.responsiveSize(0.12, 60),
        height: orientation.responsiveSize(0.1, 50),
        padding: EdgeInsets.all(orientation.shortestSide * 0.015),
        decoration: BoxDecoration(
          color: isActive
              ? Theme.of(context).elevatedButtonTheme.style!.backgroundColor!.resolve({})
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8), // Alinhado com elevatedButtonTheme
        ),
        child: Image.asset(
          path,
          color: Theme.of(context).appBarTheme.iconTheme?.color, // Usa iconTheme.color
          height: orientation.responsiveSize(0.05, 24),
          width: orientation.responsiveSize(0.05, 24),
        ),
      ),
    );
  }
}
