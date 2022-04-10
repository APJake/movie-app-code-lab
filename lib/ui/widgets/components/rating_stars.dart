import 'package:flutter/material.dart';

import '../../theme.dart';

class RatingStars extends StatelessWidget {
  final double average;
  final Color color;
  final double size;
  final int stars;
  const RatingStars({
    Key? key,
    required this.average,
    this.color = AppColors.primary,
    this.size = 15,
    this.stars = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int ratedStars = (average / 10.0 * stars).round();
    return Wrap(
        children: List.generate(stars, (index) {
      if (index < ratedStars) {
        return Icon(
          Icons.star,
          color: color,
          size: size,
        );
      } else {
        return Icon(
          Icons.star_outline,
          color: color,
          size: size,
        );
      }
    }));
  }
}
