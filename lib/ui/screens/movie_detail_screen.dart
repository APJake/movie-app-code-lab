import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/config/app_config.dart';
import 'package:movie_app/cubit/movie_detail/movie_detail_cubit.dart';
import 'package:movie_app/data/model/genre.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/ui/model/movie_detail_ui.dart';
import 'package:movie_app/ui/theme.dart';
import 'package:movie_app/ui/widgets/components/bandage.dart';
import 'package:movie_app/ui/widgets/components/big_text.dart';
import 'package:movie_app/ui/widgets/components/custom_image.dart';
import 'package:movie_app/ui/widgets/components/error_view.dart';
import 'package:movie_app/ui/widgets/components/loading_view.dart';
import 'package:movie_app/ui/widgets/components/rating_stars.dart';
import 'package:movie_app/ui/widgets/components/small_text.dart';
import 'package:movie_app/utils/navigation_service.dart';
import 'package:movie_app/utils/use_me.dart';
import 'package:readmore/readmore.dart';

import '../../cubit/movie_credits/movie_credits_cubit.dart';
import '../../utils/extensions.dart';
import '../model/person.dart';
import '../widgets/components/anchor_text.dart';
import '../widgets/person_list_session.dart';

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
    getIt.call<MovieDetailCubit>().loadMovie(movie.id);
    getIt.call<MovieCreditsCubit>().loadCredits(movie.id);
    return SliverToBoxAdapter(
      child: SingleChildScrollView(
        child: Column(
          children: [const SizedBox(height: 2), _movieInfo()],
        ),
      ),
    );
  }

  _timeAndGenres(int minutes, List<Genre> genres) => Container(
        width: _screenWidth,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 6,
          runSpacing: 6,
          children: [
            const Icon(
              Icons.watch_later_outlined,
              color: AppColors.primary,
            ),
            SmallText(
              UseMe.minutesToReadableTimeString(minutes),
              color: AppColors.text,
              fontWeight: FontWeight.bold,
            ),
            ...List.generate(
              genres.length,
              (index) => Bandage(
                genres[index].name,
                color: AppColors.text,
                backgroundColors: const [
                  AppColors.tertiary,
                  AppColors.tertiary
                ],
              ),
            ),
            const SizedBox(width: 20),
            GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.favorite_outline_rounded,
                  color: AppColors.text,
                ))
          ],
        ),
      );

  _movieInfo() => BlocBuilder<MovieDetailCubit, MovieDetailState>(
        builder: (context, state) {
          if (state is MovieDetailLoading) {
            return const LoadingView();
          } else if (state is MovieDetailLoaded) {
            return _movieInfoView(state.movie);
          } else if (state is MovieDetailError) {
            return ErrorView(message: state.message);
          }
          return const ErrorView();
        },
      );

  _storyLineSession(story) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BigText(
              "STORYLINE",
              color: AppColors.hint,
              size: AppSizes.smallFont,
            ),
            const SizedBox(height: 10),
            SmallText(
              story,
              color: AppColors.text,
              size: AppSizes.smallFont,
            ),
          ],
        ),
      );

  _trailerAndRateButtons() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              onTap: () {},
              child: const Bandage(
                "PLAY TRAILER",
                icon: Icons.play_circle_rounded,
                size: AppSizes.smallFont,
                iconColor: AppColors.backgroundTransparent,
                horizontalPadding: 14,
                verticalPadding: 8,
              ),
            ),
            const SizedBox(width: 10),
            InkWell(
              customBorder: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(100),
              ),
              onTap: () {},
              child: const Bandage(
                "RATE MOVIE",
                icon: Icons.star_rounded,
                size: AppSizes.smallFont,
                iconColor: AppColors.primary,
                horizontalPadding: 14,
                isOutlined: true,
                verticalPadding: 8,
              ),
            ),
          ],
        ),
      );

  _actorList() => Container(
        margin: const EdgeInsets.only(top: 20),
        color: AppColors.backgroundVarient,
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SmallText(
                    "BEST ACTORS",
                    size: AppSizes.xSmallFont,
                    fontWeight: FontWeight.w900,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: AppSizes.profileItemHeight,
              child: BlocBuilder<MovieCreditsCubit, MovieCreditsState>(
                builder: (context, state) {
                  if (state is MovieCreditsLoading) {
                    return const LoadingView();
                  }
                  if (state is MovieCreditsLoaded) {
                    return PersonListSession(state.credits.cast
                        .map((e) => Person.fromCast(e))
                        .toList());
                  }
                  if (state is MovieCreditsError) {
                    return ErrorView(message: state.message);
                  }
                  return const ErrorView();
                },
              ),
            ),
          ],
        ),
      );

  _creatorList() => Container(
        margin: const EdgeInsets.only(top: 20),
        color: AppColors.backgroundVarient,
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  SmallText(
                    "BEST ACTORS",
                    size: AppSizes.xSmallFont,
                    fontWeight: FontWeight.w900,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: AppSizes.profileItemHeight,
              child: BlocBuilder<MovieCreditsCubit, MovieCreditsState>(
                builder: (context, state) {
                  if (state is MovieCreditsLoading) {
                    return const LoadingView();
                  }
                  if (state is MovieCreditsLoaded) {
                    return PersonListSession(state.credits.crew
                        .map((e) => Person.fromCrew(e))
                        .toList());
                  }
                  if (state is MovieCreditsError) {
                    return ErrorView(message: state.message);
                  }
                  return const ErrorView();
                },
              ),
            ),
          ],
        ),
      );

  _aboutFilm(originalTitle, type, production, premiere, description) =>
      Container(
        width: _screenWidth,
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const BigText(
              "ABOUT FILM",
              color: AppColors.hint,
              size: AppSizes.smallFont,
            ),
            const SizedBox(height: 10),
            Table(
              columnWidths: const {0: FixedColumnWidth(120)},
              children: [
                TableRow(children: [
                  const BigText(
                    "Original Title:",
                    color: AppColors.hintPale,
                    size: AppSizes.smallFont,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SmallText(
                      originalTitle,
                      color: AppColors.text,
                      size: AppSizes.smallFont,
                    ),
                  ),
                ]),
                TableRow(children: [
                  const BigText(
                    "Type:",
                    color: AppColors.hintPale,
                    size: AppSizes.smallFont,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SmallText(
                      type,
                      color: AppColors.text,
                      size: AppSizes.smallFont,
                    ),
                  ),
                ]),
                TableRow(children: [
                  const BigText(
                    "Production:",
                    color: AppColors.hintPale,
                    size: AppSizes.smallFont,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SmallText(
                      production,
                      color: AppColors.text,
                      size: AppSizes.smallFont,
                    ),
                  ),
                ]),
                TableRow(children: [
                  const BigText(
                    "Premiere:",
                    color: AppColors.hintPale,
                    size: AppSizes.smallFont,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: SmallText(
                      premiere,
                      color: AppColors.text,
                      size: AppSizes.smallFont,
                    ),
                  ),
                ]),
                TableRow(children: [
                  const BigText(
                    "Description:",
                    color: AppColors.hintPale,
                    size: AppSizes.smallFont,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ReadMoreText(
                      description,
                      trimLines: 5,
                      colorClickableText: AppColors.text,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'MORE',
                      trimExpandedText: 'LESS',
                      lessStyle: const TextStyle(
                          color: AppColors.primary,
                          fontSize: AppSizes.smallFont,
                          fontWeight: FontWeight.bold),
                      moreStyle: const TextStyle(
                          color: AppColors.primary,
                          fontSize: AppSizes.smallFont,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ]),
              ],
            )
          ],
        ),
      );

  _movieInfoView(MovieDetailUi movieDetail) => Column(children: [
        _timeAndGenres(movieDetail.runtime, movieDetail.genres),
        _storyLineSession(movieDetail.overview),
        _trailerAndRateButtons(),
        _actorList(),
        _aboutFilm(
          movieDetail.originalTitle,
          movieDetail.genresString,
          movieDetail.productionCountries,
          movieDetail.releaseDateString,
          movieDetail.overview,
        ),
        _creatorList(),
      ]);

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: AppColors.background,
      body: MultiBlocProvider(
        providers: [
          BlocProvider<MovieDetailCubit>(
            create: (context) => getIt.call(),
          ),
          BlocProvider<MovieCreditsCubit>(
            create: (context) => getIt.call(),
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
