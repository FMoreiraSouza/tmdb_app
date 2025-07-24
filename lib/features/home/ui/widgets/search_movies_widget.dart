import 'package:flutter/material.dart';
import 'package:tmdb_app/core/enums/widget_states.dart';
import 'package:tmdb_app/core/utils/reponsivity_utils.dart';
import 'package:tmdb_app/features/home/controllers/search_movies_controller.dart';
import 'package:tmdb_app/core/constants/app_constants.dart';
import 'package:tmdb_app/features/home/ui/widgets/movie_list_widget.dart';

class SearchMoviesWidget extends StatefulWidget {
  final SearchMoviesController controller;

  const SearchMoviesWidget({super.key, required this.controller});

  @override
  State<SearchMoviesWidget> createState() => _SearchMoviesWidgetState();
}

class _SearchMoviesWidgetState extends State<SearchMoviesWidget> {
  final _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    widget.controller.reset();
    _searchController.clear();
    _searchController.addListener(() {
      widget.controller.setQuery(_searchController.text);
    });

    widget.controller.addListener(() {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          final maxScroll = _scrollController.position.maxScrollExtent;
          _scrollController.jumpTo(maxScroll / 3);
        }
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final orientation = ResponsivityUtils(context);
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
                padding: orientation.responsivePadding(
                  horizontalPercentage: AppConstants.searchHorizontalPaddingPercentage,
                  verticalPercentage: AppConstants.searchVerticalPaddingPercentage,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppConstants.getDefaultCardColor(context),
                    borderRadius: orientation.responsiveBorderRadius(
                      AppConstants.searchBorderRadiusPercentage,
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar filmes',
                      hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
                        fontSize: orientation.responsiveSize(
                          AppConstants.textSizePercentage,
                          AppConstants.textSizeBase,
                        ),
                      ),
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppConstants.getDefaultAppBarIconColor(context),
                        size: orientation.responsiveSize(
                          AppConstants.searchIconSizePercentage,
                          AppConstants.searchIconSizeBase,
                        ),
                      ),
                      contentPadding: orientation.responsivePadding(
                        horizontalPercentage: AppConstants.searchHorizontalPaddingPercentage,
                        verticalPercentage: AppConstants.searchVerticalPaddingPercentage,
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontSize: orientation.responsiveSize(
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
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: SizedBox(
                    height:
                        orientation.screenHeight -
                        kToolbarHeight -
                        MediaQuery.of(context).padding.top -
                        orientation
                            .responsivePadding(
                              verticalPercentage: AppConstants.searchVerticalPaddingPercentage,
                            )
                            .vertical,
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
                        );
                      },
                    ),
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
