import 'package:flutter/material.dart';
import 'package:tmdb_app/core/enums/widget_states.dart';
import 'package:tmdb_app/core/utils/reponsivity_utils.dart';
import 'package:tmdb_app/core/constants/app_constants.dart';
import 'package:tmdb_app/features/home/controllers/search_movies_controller.dart';
import 'package:tmdb_app/features/home/ui/widgets/movie_list_widget.dart';

class SearchMoviesWidget extends StatefulWidget {
  final SearchMoviesController controller;

  const SearchMoviesWidget({super.key, required this.controller});

  @override
  State<SearchMoviesWidget> createState() => _SearchMoviesWidgetState();
}

class _SearchMoviesWidgetState extends State<SearchMoviesWidget> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    widget.controller.reset();
    _searchController.clear();
    _searchController.addListener(() {
      widget.controller.setQuery(_searchController.text);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsivity = ResponsivityUtils(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(title: const Text('Busca'), automaticallyImplyLeading: false),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: responsivity.responsivePadding(
                  horizontalPercentage: AppConstants.searchHorizontalPaddingPercentage,
                  verticalPercentage: AppConstants.searchVerticalPaddingPercentage,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppConstants.getDefaultCardColor(context),
                    borderRadius: responsivity.responsiveBorderRadius(
                      AppConstants.searchBorderRadiusPercentage,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar filmes',
                      hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
                        fontSize: responsivity.responsiveSize(
                          AppConstants.textSizePercentage,
                          AppConstants.textSizeBase,
                        ),
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppConstants.getDefaultAppBarIconColor(context),
                        size: responsivity.responsiveSize(
                          AppConstants.searchIconSizePercentage,
                          AppConstants.searchIconSizeBase,
                        ),
                      ),
                      contentPadding: responsivity.responsivePadding(
                        horizontalPercentage: AppConstants.searchHorizontalPaddingPercentage,
                        verticalPercentage: AppConstants.searchVerticalPaddingPercentage,
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: responsivity.responsiveSize(
                        AppConstants.textSizePercentage,
                        AppConstants.textSizeBase,
                      ),
                    ),
                    onSubmitted: (_) {
                      FocusScope.of(context).unfocus();
                    },
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(
                  height: responsivity.availableContentHeight(),
                  child: AnimatedBuilder(
                    animation: widget.controller,
                    builder: (context, _) {
                      return MovieListWidget(
                        movies: widget.controller.movies,
                        state: WidgetStates(currentState: widget.controller.state),
                        loadingMessage: 'Buscando filmes',
                        emptyMessage: 'Nenhum filme encontrado para esta busca.',
                        errorMessage: 'Erro ao buscar filmes',
                        onRetry: () => widget.controller.setQuery(_searchController.text),
                        showDivider: true,
                        verticalPadding: AppConstants.verticalPaddingPercentage,
                        horizontalPadding: AppConstants.horizontalPaddingPercentage,
                        isPopularMovies: false,
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
