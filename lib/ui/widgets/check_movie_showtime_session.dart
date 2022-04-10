import 'package:flutter/material.dart';
import 'package:movie_app/ui/widgets/components/anchor_text.dart';

import '../theme.dart';
import 'components/big_text.dart';

class CheckMovieShowTimeSession extends StatelessWidget {
  const CheckMovieShowTimeSession({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (AppSizes.movieItemHeight / 2) + 10,
      decoration:
          const BoxDecoration(color: AppColors.backgroundPale, boxShadow: [
        BoxShadow(
          color: Color.fromARGB(46, 0, 0, 0),
          offset: Offset(0, 0),
          blurRadius: 30,
        )
      ]),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const BigText(
                  "Check Movie\nShowtimes",
                  maxLines: 2,
                ),
                AnchorText(
                  onTap: () {},
                  text: "SEE MORE",
                  color: AppColors.primary,
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 20, bottom: 10),
            child: Icon(
              Icons.location_on,
              size: AppSizes.mediumIcon,
              color: AppColors.text,
            ),
          )
        ],
      ),
    );
  }
}
