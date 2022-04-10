import 'package:flutter/material.dart';
import 'package:movie_app/ui/theme.dart';

class Bandage extends StatelessWidget {
  final String text;
  final double size;
  final List<Color>? backgroundColors;
  final Color color;
  final IconData? icon;
  final Color iconColor;
  final double iconSize;
  final FontWeight fontWeight;
  final double horizontalPadding;
  final double verticalPadding;
  final bool isOutlined;
  const Bandage(
    this.text, {
    Key? key,
    this.size = AppSizes.xSmallFont,
    this.backgroundColors,
    this.color = AppColors.onPrimary,
    this.icon,
    this.horizontalPadding = 7,
    this.verticalPadding = 6,
    this.iconSize = AppSizes.xSmallIcon,
    this.iconColor = AppColors.onPrimary,
    this.fontWeight = FontWeight.bold,
    this.isOutlined = false,
  }) : super(key: key);

  _bandageText() => Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: size,
          fontWeight: fontWeight,
        ),
      );
  _withIcon() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
          const SizedBox(width: 5),
          _bandageText(),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: horizontalPadding, vertical: verticalPadding),
      decoration: BoxDecoration(
        gradient: isOutlined
            ? null
            : LinearGradient(
                colors: backgroundColors ??
                    [AppColors.primaryDark, AppColors.primary]),
        borderRadius: BorderRadius.circular(100),
        border: isOutlined
            ? Border.all(
                color: color,
                width: 2,
              )
            : null,
      ),
      child: icon == null ? _bandageText() : _withIcon(),
    );
  }
}
