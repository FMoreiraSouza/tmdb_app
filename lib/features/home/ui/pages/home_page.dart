import 'package:flutter/material.dart';
import 'package:tmdb_app/core/di/app_di.dart';
import 'package:tmdb_app/features/home/controllers/popular_movies_controller.dart';
import 'package:tmdb_app/features/home/ui/widgets/popular_movies_widget.dart';
import 'package:tmdb_app/features/home/controllers/search_movies_controller.dart';
import 'package:tmdb_app/features/home/ui/widgets/search_movies_widget.dart';

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
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
              bottom: 20,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(30),
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
                        ),
                        const SizedBox(width: 8),
                        _buildSwitchButton(
                          path: 'assets/icons/search.png',
                          isActive: _currentIndex == 1,
                          onTap: () {
                            setState(() {
                              _currentIndex = 1;
                            });
                          },
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
    );
  }

  Widget _buildSwitchButton({
    required String path,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        width: 60,
        height: 50,
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF2B64DF) : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Image.asset(path, color: Colors.white, height: 24, width: 24),
      ),
    );
  }
}
