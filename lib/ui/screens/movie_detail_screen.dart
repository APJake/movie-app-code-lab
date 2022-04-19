import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/app_config.dart';
import 'package:movie_app/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/ui/theme.dart';
import 'package:movie_app/ui/widgets/components/bandage.dart';
import 'package:movie_app/ui/widgets/components/big_text.dart';
import 'package:movie_app/ui/widgets/components/custom_image.dart';
import 'package:movie_app/ui/widgets/components/rating_stars.dart';
import 'package:movie_app/ui/widgets/components/small_text.dart';
import 'package:movie_app/ui/widgets/movie_detail_session.dart';
import 'package:movie_app/utils/navigation_service.dart';

import '../../cubit/movie_credits/movie_credits_cubit.dart';
import '../../utils/extensions.dart';

class MovieDetailScreen extends StatelessWidget {
  final Movie movie;

  static const String routeName = "/detail";
  static Route route(Movie movie) {
    return MaterialPageRoute(
      builder: (context) => MovieDetailScreen(
        movie: movie,
      ),
    );
  }

  static late double _screenWidth;

  const MovieDetailScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  _header() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: _screenWidth,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Bandage("2016"),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingStars(average: movie.voteAverage),
                    const SizedBox(height: 2),
                    SmallText(
                      "${movie.voteCount} VOTES",
                      fontWeight: FontWeight.w900,
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
                const SizedBox(width: 8),
                BigText(
                  movie.voteCount.toSeparatedString(),
                  size: AppSizes.xxxBigFont,
                  fontWeight: FontWeight.w300,
                ),
              ],
            )
          ],
        ),
      );

  _title() => Container(
      width: _screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BigText(
        movie.title,
        maxLines: 3,
        size: AppSizes.bigFont,
      ));

  _appBar() => SliverAppBar(
        backgroundColor: AppColors.secondary,
        pinned: false,
        elevation: 0,
        snap: false,
        expandedHeight: AppSizes.mainBackdropHeight,
        floating: false,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.search_rounded,
                color: AppColors.text,
                size: AppSizes.smallIcon,
              )),
          const SizedBox(width: 15),
        ],
        leading: Align(
            child: IconButton(
                onPressed: () {
                  getIt.call<NavigationService>().back();
                },
                icon: const CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.backgroundTransparent,
                  child: Icon(
                    Icons.chevron_left_rounded,
                    size: AppSizes.smallIcon,
                    color: AppColors.text,
                  ),
                ))),
        flexibleSpace: Stack(
          children: [
            _backgoundImage(),
            Positioned(
              bottom: AppSizes.mainHeaderMarginBottom,
              child: Column(
                children: [
                  _header(),
                  _title(),
                ],
              ),
            )
          ],
        ),
      );
  _backgoundImage() => CustomImage(
        imageUrl: movie.backdropPath,
        width: _screenWidth,
        height: double.infinity,
        isGradient: true,
      );

  _body() {
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Column(
          children: [const SizedBox(height: 2), MovieDetailSession(movie.id)],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.background,
      body: MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailCubit>(
            create: (context) =>
                MovieDetailCubit(getIt.call(), movieId: movie.id),
          ),
          BlocProvider<MovieCreditsCubit>(
            create: (context) =>
                MovieCreditsCubit(getIt.call(), movieId: movie.id),
          ),
        ],
        child: CustomScrollView(slivers: [
          _appBar(),
          _body(),
        ]),
      ),
    );
  }
}
