import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/ui/widgets/person_list_session.dart';
import 'package:readmore/readmore.dart';
import '../../config/app_config.dart';
import '../../cubit/movie_credits/movie_credits_cubit.dart';
import '../../cubit/movie_detail/movie_detail_cubit.dart';
import '../../data/model/genre.dart';
import '../../utils/use_me.dart';
import '../model/movie_detail_ui.dart';
import '../model/person.dart';
import '../theme.dart';
import 'components/bandage.dart';
import 'components/big_text.dart';
import 'components/error_view.dart';
import 'components/loading_view.dart';
import 'components/small_text.dart';

class MovieDetailSession extends StatelessWidget {
  final int movieId;
  const MovieDetailSession(this.movieId, {Key? key}) : super(key: key);

  static late double _screenWidth;

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;

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
                      "ACTORS",
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
                  builder: (_, castState) {
                    if (castState is MovieCreditsLoading) {
                      return const LoadingView();
                    }
                    if (castState is MovieCreditsLoaded) {
                      return PersonListSession(castState.credits.cast
                          .map((e) => Person.fromCast(e))
                          .toList());
                    }
                    if (castState is MovieCreditsError) {
                      return ErrorView(message: castState.message);
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

    return BlocBuilder<MovieDetailCubit, MovieDetailState>(
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
  }
}
