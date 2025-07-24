import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tmdb_app/core/constants/api_constants.dart';
import 'package:tmdb_app/core/utils/reponsivity_utils.dart';
import 'package:tmdb_app/core/constants/app_constants.dart';
import 'package:tmdb_app/data/models/movie_model.dart';

class SearchMovieItemWidget extends StatelessWidget {
  final MovieModel movie;
  final ResponsivityUtils responsivity;
  final bool showDuration;
  final bool showRating;
  final bool showDivider;

  const SearchMovieItemWidget({
    super.key,
    required this.movie,
    required this.responsivity,
    this.showDuration = false,
    this.showRating = false,
    this.showDivider = false,
  });

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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Flexible(flex: 1, child: imageWidget),
            SizedBox(width: responsivity.defaultSpacing()),
            Expanded(
              flex: 3,
              child: Text(
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
            ),
          ],
        ),
        Padding(
          padding: responsivity.responsivePadding(
            verticalPercentage: AppConstants.dividerVerticalPaddingPercentage,
          ),
          child: Divider(
            color: AppConstants.getDefaultIconColor(context),
            height: responsivity.dividerHeight(),
            thickness: 0.2,
          ),
        ),
      ],
    );

    return contentWidget;
  }
}
