import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_app/core/constants/api_constants.dart';
import 'package:tmdb_app/core/utils/reponsivity_utils.dart';
import 'package:tmdb_app/core/constants/app_constants.dart';

class MovieItemWidget extends StatelessWidget {
  final dynamic movie;
  final ResponsivityUtils orientation;
  final bool showDuration;
  final bool showRating;
  final bool showDivider;

  const MovieItemWidget({
    super.key,
    required this.movie,
    required this.orientation,
    this.showDuration = false,
    this.showRating = false,
    this.showDivider = false,
  });

  String formatDuration(int? minutes) {
    if (minutes == null || minutes <= 0) return 'N/A';
    final hours = minutes ~/ 60;
    final remainingMinutes = minutes % 60;
    return '${hours}h${remainingMinutes}m';
  }

  @override
  Widget build(BuildContext context) {
    Widget imageWidget = SizedBox(
      width: orientation.responsiveSize(
        AppConstants.imageSizePercentage,
        AppConstants.imageSizeBase,
      ),
      height: orientation.responsiveSize(
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
                  size: orientation.responsiveSize(
                    AppConstants.smallIconSizePercentage,
                    AppConstants.smallIconSizeBase,
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Icon(
                Icons.error,
                size: orientation.responsiveSize(
                  AppConstants.iconSizePercentage,
                  AppConstants.iconSizeBase,
                ),
                color: AppConstants.getDefaultAppBarIconColor(context),
              ),
            )
          : Icon(
              Icons.movie,
              size: orientation.responsiveSize(
                AppConstants.imageSizePercentage,
                AppConstants.imageSizeBase,
              ),
              color: AppConstants.getDefaultAppBarIconColor(context),
            ),
    );

    Widget contentWidget = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(flex: 1, child: imageWidget),
            SizedBox(width: orientation.shortestSide * AppConstants.defaultSpacingPercentage),
            Expanded(
              flex: 3,
              child: Text(
                movie.title,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: orientation.responsiveSize(
                    AppConstants.textSizePercentage,
                    AppConstants.textSizeBase,
                  ),
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (showRating)
              Container(
                width: orientation.responsiveSize(
                  AppConstants.ratingContainerSizePercentage,
                  AppConstants.ratingContainerSizeBase,
                ),
                height: orientation.responsiveSize(
                  AppConstants.ratingContainerSizePercentage,
                  AppConstants.ratingContainerSizeBase,
                ),
                decoration: BoxDecoration(
                  color: AppConstants.getDefaultButtonColor(context),
                  borderRadius: orientation.responsiveBorderRadius(
                    AppConstants.ratingBorderRadiusPercentage,
                  ),
                ),
                child: Center(
                  child: Text(
                    (movie.voteAverage * 10).round().toString(),
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontSize: orientation.responsiveSize(
                        AppConstants.smallTextSizePercentage,
                        AppConstants.smallTextSizeBase,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        if (showDuration)
          Padding(
            padding: orientation.responsivePadding(
              verticalPercentage: AppConstants.cardVerticalMarginPercentage,
            ),
            child: Row(
              children: [
                Flexible(
                  child: Icon(
                    Icons.access_time,
                    color: AppConstants.getDefaultIconColor(context),
                    size: orientation.responsiveSize(
                      AppConstants.tinyIconSizePercentage,
                      AppConstants.tinyIconSizeBase,
                    ),
                  ),
                ),
                SizedBox(width: orientation.shortestSide * AppConstants.smallSpacingPercentage),
                Flexible(
                  child: Text(
                    formatDuration(movie.runtime),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: orientation.responsiveSize(
                        AppConstants.tinyIconSizePercentage,
                        AppConstants.tinyIconSizeBase,
                      ),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        if (showDivider)
          Padding(
            padding: orientation.responsivePadding(
              verticalPercentage: AppConstants.dividerVerticalPaddingPercentage,
            ),
            child: Divider(
              color: AppConstants.getDefaultIconColor(context),
              height: orientation.shortestSide * AppConstants.dividerHeightPercentage,
              thickness: 0.2,
            ),
          ),
      ],
    );

    return showDuration || showRating
        ? Card(
            margin: orientation.responsiveMargin(
              verticalPercentage: AppConstants.cardVerticalMarginPercentage,
              horizontalPercentage: AppConstants.cardHorizontalMarginPercentage,
            ),
            color: AppConstants.getDefaultCardColor(context),
            child: contentWidget,
          )
        : contentWidget;
  }
}
