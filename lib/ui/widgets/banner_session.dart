import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubit/banner_counter/banner_counter_cubit.dart';
import 'package:movie_app/ui/theme.dart';
import 'package:movie_app/ui/widgets/components/big_text.dart';
import 'package:movie_app/ui/widgets/components/custom_image.dart';
import 'package:movie_app/ui/widgets/components/error_view.dart';
import 'package:movie_app/ui/widgets/components/loading_view.dart';
import 'package:movie_app/utils/navigation_service.dart';

import '../../config/app_config.dart';
import '../../cubit/now_playing_movies/now_playing_movies_cubit.dart';
import '../../data/model/movie.dart';
import '../screens/movie_detail_screen.dart';

class BannerSession extends StatelessWidget {
  const BannerSession({Key? key}) : super(key: key);

  static late double _screenWidth;

  _movieItem(Movie movie) => SizedBox(
        width: _screenWidth,
        child: Stack(
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: .2),
                height: double.infinity,
                child: CustomImage(
                  imageUrl: movie.backdropPath,
                  isGradient: true,
                  height: AppSizes.bannerHeight,
                )),
            Positioned.fill(
                bottom: 60,
                child: IconButton(
                    onPressed: () {
                      getIt
                          .call<NavigationService>()
                          .to(MovieDetailScreen.routeName, arguments: movie);
                    },
                    icon: const Icon(
                      Icons.play_circle,
                      size: AppSizes.xBigIcon,
                      color: AppColors.primary,
                    ))),
            Positioned(
                bottom: 30,
                child: Container(
                  width: _screenWidth,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        "${movie.title} ${movie.releaseDate?.year ?? ""}.",
                        size: AppSizes.xBigFont,
                      ),
                      const BigText(
                        "Official Review.",
                        size: AppSizes.xBigFont,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      );

  _movieList(List<Movie> movies) => BlocConsumer<BannerCounterCubit, double>(
        listener: (context, state) {},
        builder: (context, state) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              PageView.builder(
                itemBuilder: ((context, index) => _movieItem(movies[index])),
                itemCount: 5,
                onPageChanged: (index) =>
                    BlocProvider.of<BannerCounterCubit>(context)
                        .change(index.toDouble()),
                scrollDirection: Axis.horizontal,
              ),
              Positioned(
                bottom: 10,
                child: DotsIndicator(
                  dotsCount: 5,
                  position: state,
                  decorator: const DotsDecorator(
                      activeColor: AppColors.primary, color: AppColors.hint),
                ),
              )
            ],
          );
        },
      );

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    getIt.call<NowPlayingMoviesCubit>().loadMovies();
    return SizedBox(
      height: AppSizes.bannerHeight,
      child: BlocBuilder<NowPlayingMoviesCubit, NowPlayingMoviesState>(
        builder: (context, state) {
          if (state is NowPlayingLoading) {
            return const LoadingView();
          }
          if (state is NowPlayingLoaded) {
            return _movieList(state.movies);
          }
          if (state is NowPlayingError) {
            return ErrorView(message: state.message);
          }
          return const ErrorView();
        },
      ),
    );
  }
}
