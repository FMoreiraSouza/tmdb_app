import 'package:flutter/material.dart';
import 'package:tmdb_app/core/di/app_di.dart';
import 'package:tmdb_app/features/home/controllers/popular_movies_controller.dart';
import 'package:tmdb_app/features/home/ui/widgets/popular_movies_widget.dart';
import 'package:tmdb_app/features/home/controllers/search_movies_controller.dart';
import 'package:tmdb_app/features/home/ui/widgets/search_movies_widget.dart';
import 'package:tmdb_app/core/utils/reponsivity_utils.dart';
import 'package:tmdb_app/core/constants/app_constants.dart';

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
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: orientation.responsivePadding(
            verticalPercentage: AppConstants.verticalPaddingPercentage,
          ),
          child: Stack(
            children: [
              AnimatedSwitcher(
                duration: AppConstants.switcherAnimationDuration,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(opacity: animation, child: child);
                },
                child: _pages[_currentIndex],
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: orientation.shortestSide * AppConstants.bottomNavigationSpacingPercentage,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: orientation.responsiveMargin(
                        horizontalPercentage: AppConstants.horizontalMarginPercentage,
                      ),
                      padding: EdgeInsets.all(
                        orientation.shortestSide * AppConstants.switchButtonPaddingPercentage,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: orientation.responsiveBorderRadius(
                          AppConstants.borderRadiusPercentage,
                        ),
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
                          SizedBox(
                            width: orientation.shortestSide * AppConstants.defaultSpacingPercentage,
                          ),
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
        duration: AppConstants.buttonAnimationDuration,
        curve: AppConstants.buttonAnimationCurve,
        width: orientation.responsiveSize(
          AppConstants.switchButtonWidthPercentage,
          AppConstants.switchButtonWidthBase,
        ),
        height: orientation.responsiveSize(
          AppConstants.switchButtonHeightPercentage,
          AppConstants.switchButtonHeightBase,
        ),
        padding: EdgeInsets.all(
          orientation.shortestSide * AppConstants.switchButtonPaddingPercentage,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppConstants.getDefaultButtonColor(context) : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Image.asset(
          path,
          color: AppConstants.getDefaultAppBarIconColor(context),
          height: orientation.responsiveSize(
            AppConstants.switchButtonImageSizePercentage,
            AppConstants.switchButtonImageSizeBase,
          ),
          width: orientation.responsiveSize(
            AppConstants.switchButtonImageSizePercentage,
            AppConstants.switchButtonImageSizeBase,
          ),
        ),
      ),
    );
  }
}
