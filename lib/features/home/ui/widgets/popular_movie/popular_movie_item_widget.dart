import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_app/core/constants/api_constants.dart';
import 'package:tmdb_app/core/utils/reponsivity_utils.dart';
import 'package:tmdb_app/core/constants/app_constants.dart';
import 'package:tmdb_app/data/models/movie_model.dart';

class PopularMovieItemWidget extends StatelessWidget {
  final MovieModel movie;
  final ResponsivityUtils responsivity;

  const PopularMovieItemWidget({super.key, required this.movie, required this.responsivity});

  String formatDuration(int? minutes) {
    if (minutes == null || minutes <= 0) return 'N/A';
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return '${hours}h${remainingMinutes}m';
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = SizedBox(
      width: responsivity.responsiveSize(
        AppConstants.imageSizePercentage,
        AppConstants.imageSizeBase,
      ),
      height: responsivity.responsiveSize(
        AppConstants.imageSizePercentage,
        AppConstants.imageSizeBase,
      ),
      child: movie.posterPath != null
          ? CachedNetworkImage(
              imageUrl: '${ApiConstants.imageBaseUrl}${movie.posterPath}',
              fit: BoxFit.cover,
              placeholder: (context, url) => Center(
                child: SpinKitCircle(
                  color: AppConstants.getDefaultButtonColor(context),
                  size: responsivity.responsiveSize(
                    AppConstants.smallIconSizePercentage,
                    AppConstants.smallIconSizeBase,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                size: responsivity.responsiveSize(
                  AppConstants.iconSizePercentage,
                  AppConstants.iconSizeBase,
                ),
                color: AppConstants.getDefaultAppBarIconColor(context),
              ),
            )
          : Icon(
              Icons.movie,
              size: responsivity.responsiveSize(
                AppConstants.imageSizePercentage,
                AppConstants.imageSizeBase,
              ),
              color: AppConstants.getDefaultAppBarIconColor(context),
            ),
    );

    Widget contentWidget = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: responsivity.defaultSpacing()),
          leading: imageWidget,
          title: Text(
            movie.title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontSize: responsivity.responsiveSize(
                AppConstants.textSizePercentage,
                AppConstants.textSizeBase,
              ),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Row(
            children: [
              Icon(
                Icons.access_time,
                color: AppConstants.getDefaultIconColor(context),
                size: responsivity.responsiveSize(
                  AppConstants.tinyIconSizePercentage,
                  AppConstants.tinyIconSizeBase,
                ),
              ),
              SizedBox(width: responsivity.smallSpacing()),
              Text(
                formatDuration(movie.runtime),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontSize: responsivity.responsiveSize(
                    AppConstants.tinyIconSizePercentage,
                    AppConstants.tinyIconSizeBase,
                  ),
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          trailing: Container(
            width: responsivity.responsiveSize(
              AppConstants.ratingContainerSizePercentage,
              AppConstants.ratingContainerSizeBase,
            ),
            height: responsivity.responsiveSize(
              AppConstants.ratingContainerSizePercentage,
              AppConstants.ratingContainerSizeBase,
            ),
            decoration: BoxDecoration(
              color: AppConstants.getDefaultButtonColor(context),
              borderRadius: responsivity.responsiveBorderRadius(
                AppConstants.ratingBorderRadiusPercentage,
              ),
            ),
            child: Center(
              child: Text(
                (movie.voteAverage * 10).round().toString(),
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: responsivity.responsiveSize(
                    AppConstants.smallTextSizePercentage,
                    AppConstants.smallTextSizeBase,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return Card(
      margin: responsivity.responsiveMargin(
        verticalPercentage: AppConstants.cardVerticalMarginPercentage,
        horizontalPercentage: AppConstants.cardHorizontalMarginPercentage,
      ),
      color: AppConstants.getDefaultCardColor(context),
      child: Container(width: double.infinity, alignment: Alignment.center, child: contentWidget),
    );
  }
}
