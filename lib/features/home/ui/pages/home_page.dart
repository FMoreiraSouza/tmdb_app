import 'package:flutter/material.dart';
import 'package:tmdb_app/core/di/app_di.dart';
import 'package:tmdb_app/features/home/controllers/popular_movies_controller.dart';
import 'package:tmdb_app/features/home/ui/widgets/popular_movie/popular_movies_widget.dart';
import 'package:tmdb_app/features/home/controllers/search_movies_controller.dart';
import 'package:tmdb_app/features/home/ui/widgets/search_movie/search_movies_widget.dart';
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
    final responsivity = ResponsivityUtils(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Padding(
          padding: responsivity.responsivePadding(
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
                bottom: responsivity.shortestSide * AppConstants.bottomNavigationSpacingPercentage,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: responsivity.responsiveMargin(
                        horizontalPercentage: AppConstants.horizontalMarginPercentage,
                      ),
                      padding: EdgeInsets.all(
                        responsivity.shortestSide * AppConstants.switchButtonPaddingPercentage,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: responsivity.responsiveBorderRadius(
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
                            responsivity: responsivity,
                          ),
                          SizedBox(
                            width:
                                responsivity.shortestSide * AppConstants.defaultSpacingPercentage,
                          ),
                          _buildSwitchButton(
                            path: 'assets/icons/search.png',
                            isActive: _currentIndex == 1,
                            onTap: () {
                              setState(() {
                                _currentIndex = 1;
                              });
                            },
                            responsivity: responsivity,
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
    required ResponsivityUtils responsivity,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppConstants.buttonAnimationDuration,
        curve: AppConstants.buttonAnimationCurve,
        width: responsivity.responsiveSize(
          AppConstants.switchButtonWidthPercentage,
          AppConstants.switchButtonWidthBase,
        ),
        height: responsivity.responsiveSize(
          AppConstants.switchButtonHeightPercentage,
          AppConstants.switchButtonHeightBase,
        ),
        padding: EdgeInsets.all(
          responsivity.shortestSide * AppConstants.switchButtonPaddingPercentage,
        ),
        decoration: BoxDecoration(
          color: isActive ? AppConstants.getDefaultButtonColor(context) : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Image.asset(
          path,
          color: AppConstants.getDefaultAppBarIconColor(context),
          height: responsivity.responsiveSize(
            AppConstants.switchButtonImageSizePercentage,
            AppConstants.switchButtonImageSizeBase,
          ),
          width: responsivity.responsiveSize(
            AppConstants.switchButtonImageSizePercentage,
            AppConstants.switchButtonImageSizeBase,
          ),
        ),
      ),
    );
  }
}
