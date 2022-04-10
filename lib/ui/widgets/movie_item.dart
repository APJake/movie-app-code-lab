import 'package:flutter/material.dart';
import 'package:movie_app/config/app_config.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/ui/screens/movie_detail_screen.dart';
import 'package:movie_app/ui/widgets/components/big_text.dart';
import 'package:movie_app/utils/navigation_service.dart';

import '../theme.dart';
import 'components/custom_image.dart';
import 'components/rating_stars.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  const MovieItem(this.movie, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        getIt
            .call<NavigationService>()
            .to(MovieDetailScreen.routeName, arguments: movie);
      },
      child: Container(
        margin: const EdgeInsets.only(left: 16),
        width: AppSizes.movieItemWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomImage(imageUrl: movie.posterPath),
            const SizedBox(height: 10),
            BigText(
              movie.title,
              size: AppSizes.normalFont,
              fontWeight: FontWeight.normal,
            ),
            const SizedBox(height: 5),
            Row(
              children: [
                BigText(
                  movie.voteAverage.toString(),
                  size: AppSizes.xSmallFont,
                ),
                const SizedBox(width: 10),
                RatingStars(average: movie.voteAverage)
              ],
            )
          ],
        ),
      ),
    );
  }
}
