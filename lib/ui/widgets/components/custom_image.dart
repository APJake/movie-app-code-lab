import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/config/app_constants.dart';
import 'package:movie_app/ui/theme.dart';

class CustomImage extends StatelessWidget {
  final String? imageUrl;
  final String prefixUrl;
  final bool isGradient;
  final List<Color>? colorsForGradient;
  final IconData errorIcon;
  final Color errorIconColor;
  final Color loadingColor;
  final double errorIconSize;
  final double? width, height;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  const CustomImage({
    Key? key,
    required this.imageUrl,
    this.prefixUrl = AppConstants.imagePrefixUrl,
    this.isGradient = false,
    this.errorIcon = Icons.error_outline_rounded,
    this.errorIconColor = AppColors.error,
    this.loadingColor = AppColors.primary,
    this.width,
    this.height,
    this.errorIconSize = AppSizes.xBigIcon,
    this.colorsForGradient,
    this.imageBuilder,
  }) : super(key: key);

  _imageWithGradient() => Stack(
        children: [
          _imageView(),
          Container(
            width: width,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                end: Alignment.bottomCenter,
                begin: Alignment.topCenter,
                colors: colorsForGradient ??
                    [Colors.transparent, AppColors.background],
              ),
            ),
          ),
        ],
      );

  _imageView() {
    return CachedNetworkImage(
      imageUrl: prefixUrl + (imageUrl ?? ""),
      imageBuilder: imageBuilder ??
          (context, imageProvider) => Image(
                height: height,
                width: width,
                image: imageProvider,
                fit: BoxFit.cover,
              ),
      placeholder: (context, _) => SizedBox(
        child: SizedBox(
          width: width,
          height: height,
          child: Center(
            child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(color: loadingColor)),
          ),
        ),
      ),
      errorWidget: (context, _, __) {
        return SizedBox(
          width: width,
          height: height,
          child: Center(
            child: Icon(
              errorIcon,
              size: errorIconSize,
              color: errorIconColor,
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return isGradient ? _imageWithGradient() : _imageView();
  }
}
