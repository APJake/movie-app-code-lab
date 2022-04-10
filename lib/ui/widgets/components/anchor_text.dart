import 'package:flutter/material.dart';

import '../../theme.dart';

class AnchorText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final VoidCallback onTap;
  final TextOverflow overflow;
  final int maxLines;
  final FontWeight fontWeight;
  final bool underlined;
  const AnchorText({
    Key? key,
    required this.onTap,
    required this.text,
    this.color = AppColors.text,
    this.size = AppSizes.xSmallFont,
    this.overflow = TextOverflow.ellipsis,
    this.maxLines = 1,
    this.fontWeight = FontWeight.w900,
    this.underlined = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(text,
          style: TextStyle(
            color: color,
            fontWeight: fontWeight,
            decoration:
                underlined ? TextDecoration.underline : TextDecoration.none,
            fontSize: size,
          )),
    );
  }
}
