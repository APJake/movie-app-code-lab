import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubit/top_rated_movies/top_rated_movies_cubit.dart';
import 'package:movie_app/ui/widgets/components/anchor_text.dart';
import 'package:movie_app/ui/widgets/components/custom_image.dart';
import 'package:movie_app/utils/use_me.dart';
import '../../config/app_config.dart';
import '../../cubit/now_playing_movies/now_playing_movies_cubit.dart';
import '../../data/model/movie.dart';
import '../../utils/navigation_service.dart';
import '../screens/movie_detail_screen.dart';
import '../theme.dart';
import 'components/big_text.dart';
import 'components/error_view.dart';
import 'components/loading_view.dart';
import 'components/small_text.dart';

class ShowCaseSession extends StatelessWidget {
  const ShowCaseSession({Key? key}) : super(key: key);

  _movieItem(Movie movie) => Container(
        width: AppSizes.showcaseWidth,
        padding: const EdgeInsets.only(right: 20),
        height: 100,
        child: Stack(
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: .2),
                height: AppSizes.showcaseHeight,
                child: CustomImage(
                  imageUrl: movie.backdropPath,
                  isGradient: true,
                  height: AppSizes.showcaseHeight,
                  colorsForGradient: const [
                    Colors.transparent,
                    Colors.transparent,
                    Color.fromARGB(204, 30, 38, 52)
                  ],
                )),
            Positioned.fill(
              child: IconButton(
                onPressed: () {
                  getIt
                      .call<NavigationService>()
                      .to(MovieDetailScreen.routeName, arguments: movie);
                },
                icon: const Icon(
                  Icons.play_circle,
                  size: AppSizes.bigIcon,
                  color: AppColors.primary,
                ),
              ),
            ),
            Positioned(
                bottom: 10,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BigText(
                        movie.title,
                        size: AppSizes.normalFont,
                      ),
                      const SizedBox(height: 3),
                      BigText(
                        UseMe.getDateString(movie.releaseDate),
                        size: AppSizes.smallFont,
                        color: AppColors.hint,
                      ),
                    ],
                  ),
                ))
          ],
        ),
      );

  _movieList(List<Movie> movies) => ListView.builder(
        padding: const EdgeInsets.only(left: 20),
        itemBuilder: ((context, index) => _movieItem(movies[index])),
        itemCount: movies.length,
        scrollDirection: Axis.horizontal,
      );

  @override
  Widget build(BuildContext context) {
    getIt.call<TopRatedMoviesCubit>().loadMovies();
    return Container(
      color: AppColors.backgroundPale,
      height: AppSizes.showcaseContainerHeight,
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SmallText(
                  "SHOWCASES",
                  size: AppSizes.xSmallFont,
                  fontWeight: FontWeight.w900,
                ),
                AnchorText(
                  onTap: () {},
                  text: "MORE SHOWCASES",
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: AppSizes.showcaseHeight,
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
          ),
        ],
      ),
    );
  }
}
