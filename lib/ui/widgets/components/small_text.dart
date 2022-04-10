import 'package:flutter/material.dart';
import 'package:movie_app/ui/theme.dart';

class SmallText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final TextOverflow? overflow;
  final int? maxLines;
  final TextAlign? textAlign;
  final FontWeight fontWeight;
  const SmallText(
    this.text, {
    Key? key,
    this.color = AppColors.hint,
    this.size = AppSizes.xSmallFont,
    this.maxLines,
    this.overflow,
    this.textAlign,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overflow,
      maxLines: maxLines,
      textAlign: textAlign,
      style: TextStyle(fontSize: size, color: color, fontWeight: fontWeight),
    );
  }
}
