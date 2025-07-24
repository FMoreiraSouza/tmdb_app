import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_app/core/constants/api_constants.dart';
import 'package:tmdb_app/core/enums/widget_states.dart';
import 'package:tmdb_app/core/widgets/states/state_widget.dart';
import 'package:tmdb_app/core/utils/reponsivity_utils.dart';
import 'package:tmdb_app/features/home/controllers/search_movies_controller.dart';

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
        appBar: AppBar(title: const Text('Busca'), automaticallyImplyLeading: false),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: orientation.responsivePadding(
                  horizontalPercentage: 0.04,
                  verticalPercentage: 0.02,
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardTheme.color, // Usa cardTheme.color
                    borderRadius: orientation.responsiveBorderRadius(0.08),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Buscar filmes',
                      hintStyle: Theme.of(context).inputDecorationTheme.hintStyle?.copyWith(
                        fontSize: orientation.responsiveSize(0.04, 16),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Theme.of(
                          context,
                        ).appBarTheme.iconTheme?.color, // Usa iconTheme.color
                        size: orientation.responsiveSize(0.06, 24),
                      ),
                      contentPadding: orientation.responsivePadding(
                        horizontalPercentage: 0.04,
                        verticalPercentage: 0.03,
                      ),
                    ),
                    textInputAction: TextInputAction.search,
                    style: Theme.of(
                      context,
                    ).textTheme.bodyLarge?.copyWith(fontSize: orientation.responsiveSize(0.04, 16)),
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
                    height: orientation.screenHeight,
                    child: AnimatedBuilder(
                      animation: widget.controller,
                      builder: (context, _) {
                        switch (widget.controller.state) {
                          case WidgetStates.loadingState:
                            return Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SpinKitCircle(
                                    color: Theme.of(
                                      context,
                                    ).elevatedButtonTheme.style!.backgroundColor!.resolve({}),
                                    size: orientation.responsiveSize(0.1, 50),
                                  ),
                                  SizedBox(height: orientation.shortestSide * 0.03),
                                  Text(
                                    'Buscando filmes',
                                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                      fontSize: orientation.responsiveSize(0.04, 16),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          case WidgetStates.noConnection:
                            return Center(
                              child: StateWidget(
                                state: WidgetStates(currentState: WidgetStates.noConnection),
                                onRetry: () => widget.controller.setQuery(_searchController.text),
                              ),
                            );
                          case WidgetStates.emptyState:
                            return Center(
                              child: StateWidget(
                                state: WidgetStates(currentState: WidgetStates.emptyState),
                                message: 'Nenhum filme encontrado para esta busca.',
                              ),
                            );
                          case WidgetStates.successState:
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: orientation.responsivePadding(horizontalPercentage: 0.03),
                              itemCount: widget.controller.movies.length,
                              itemBuilder: (context, index) {
                                final movie = widget.controller.movies[index];
                                return Column(
                                  children: [
                                    Padding(
                                      padding: orientation.responsivePadding(
                                        verticalPercentage: 0.01,
                                      ),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: orientation.responsiveSize(0.12, 60),
                                            height: orientation.responsiveSize(0.12, 60),
                                            child: movie.posterPath != null
                                                ? CachedNetworkImage(
                                                    imageUrl:
                                                        '${ApiConstants.imageBaseUrl}${movie.posterPath}',
                                                    fit: BoxFit.cover,
                                                    placeholder: (context, url) => Center(
                                                      child: SpinKitCircle(
                                                        color: Theme.of(context)
                                                            .elevatedButtonTheme
                                                            .style!
                                                            .backgroundColor!
                                                            .resolve({}),
                                                        size: orientation.responsiveSize(0.08, 30),
                                                      ),
                                                    ),
                                                    errorWidget: (context, url, error) => Icon(
                                                      Icons.error,
                                                      color: Theme.of(
                                                        context,
                                                      ).appBarTheme.iconTheme?.color,
                                                      size: orientation.responsiveSize(0.1, 40),
                                                    ),
                                                  )
                                                : Icon(
                                                    Icons.movie,
                                                    size: orientation.responsiveSize(0.12, 60),
                                                    color: Theme.of(
                                                      context,
                                                    ).appBarTheme.iconTheme?.color,
                                                  ),
                                          ),
                                          SizedBox(width: orientation.shortestSide * 0.02),
                                          Expanded(
                                            child: Text(
                                              movie.title,
                                              style: Theme.of(context).textTheme.bodyLarge
                                                  ?.copyWith(
                                                    fontSize: orientation.responsiveSize(0.04, 16),
                                                  ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: orientation.responsivePadding(
                                        verticalPercentage: 0.01,
                                      ),
                                      child: Divider(
                                        color: Theme.of(context).textTheme.bodyMedium?.color,
                                        height: orientation.shortestSide * 0.005,
                                        thickness: 0.2,
                                      ),
                                    ),
                                  ],
                                );
                              },
                            );
                          default:
                            return Center(
                              child: StateWidget(
                                state: WidgetStates(currentState: WidgetStates.errorState),
                                message: 'Erro ao buscar filmes',
                                onRetry: () => widget.controller.setQuery(_searchController.text),
                              ),
                            );
                        }
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
