import 'package:flutter/material.dart';
import 'package:tmdb_app/core/di/app_di.dart';
import 'package:tmdb_app/features/popular_movies/controllers/popular_movies_controller.dart';
import 'package:tmdb_app/features/popular_movies/ui/pages/popular_movies_page.dart';
import 'package:tmdb_app/features/search_movies/controllers/search_movies_controller.dart';
import 'package:tmdb_app/features/search_movies/ui/pages/search_movies_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    PopularMoviesWidget(controller: AppDI.instance.get<PopularMoviesController>()),
    SearchMoviesWidget(controller: AppDI.instance.get<SearchMoviesController>()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 16.0),
        child: Stack(
          children: [
            _pages[_currentIndex],
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
                          icon: Icons.home,
                          isActive: _currentIndex == 0,
                          onTap: () {
                            setState(() {
                              _currentIndex = 0;
                            });
                          },
                        ),
                        const SizedBox(width: 8),
                        _buildSwitchButton(
                          icon: Icons.search,
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
    required IconData icon,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Icon(icon, color: Colors.white, size: 30),
      ),
    );
  }
}
