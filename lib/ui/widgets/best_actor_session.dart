import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/cubit/best_actors/best_actors_cubit.dart';
import 'package:movie_app/ui/model/person.dart';
import 'package:movie_app/ui/widgets/person_list_session.dart';
import '../../config/app_config.dart';
import '../theme.dart';
import 'components/anchor_text.dart';
import 'components/error_view.dart';
import 'components/loading_view.dart';
import 'components/small_text.dart';

class BestActorSession extends StatelessWidget {
  const BestActorSession({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    getIt.call<BestActorsCubit>().loadCasts();

    return Container(
      color: AppColors.backgroundDark,
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SmallText(
                  "BEST ACTORS",
                  size: AppSizes.xSmallFont,
                  fontWeight: FontWeight.w900,
                ),
                AnchorText(
                  onTap: () {},
                  text: "MORE ACTORS",
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: AppSizes.profileItemHeight,
            child: BlocBuilder<BestActorsCubit, BestActorsState>(
              builder: (context, state) {
                if (state is BestActorsLoading) {
                  return const LoadingView();
                }
                if (state is BestActorsLoaded) {
                  return PersonListSession(
                      state.casts.map((e) => Person.fromCast(e)).toList());
                }
                if (state is BestActorsError) {
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
