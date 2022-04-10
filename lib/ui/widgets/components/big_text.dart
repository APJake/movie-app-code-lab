import 'package:flutter/material.dart';
import 'package:movie_app/ui/theme.dart';

class BigText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final TextOverflow overflow;
  final int maxLines;
  final FontWeight fontWeight;
  const BigText(
    this.text, {
    Key? key,
    this.color = AppColors.text,
    this.size = AppSizes.bigFont,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 1,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: true,
      style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
    );
  }
}
