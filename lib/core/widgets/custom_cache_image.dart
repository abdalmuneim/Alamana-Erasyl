import 'package:alamanaelrasyl/core/resources/assets_manager.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomCacheNetwork extends StatelessWidget {
  const CustomCacheNetwork({
    super.key,
    required this.url,
    this.borderRadius,
    this.fit = BoxFit.cover,
    this.height,
    this.width,
    this.error,
    this.color,
    this.imageColor,
    this.bgErrorColor,
    this.isCircle = false,
    this.padding,
  });

  final String url;
  final BorderRadiusGeometry? borderRadius;
  final String? error;
  final BoxFit? fit;
  final double? height, width;
  final Color? color, imageColor, bgErrorColor;
  final EdgeInsetsGeometry? padding;
  final bool isCircle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
        borderRadius: isCircle
            ? null
            : borderRadius ?? BorderRadius.circular(isCircle ? MediaQuery.of(context).size.height : 10),
      ),
      child: ClipRRect(
        borderRadius:
        borderRadius ?? BorderRadius.circular(isCircle ? MediaQuery.of(context).size.height : 10),
        child: CachedNetworkImage(
          imageUrl: url,
          width: width,
          height: height,
          color: imageColor,
          fit: fit,
          errorWidget: (BuildContext context, _, stackTrace) {
            return Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
                  color: bgErrorColor ?? Colors.transparent),
              child: error != null
                  ? Image.asset(error!)
                  : LottieBuilder.asset(Assets.cantFind),
            );
          },
          progressIndicatorBuilder:
              (context, String url, DownloadProgress progress) {
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}