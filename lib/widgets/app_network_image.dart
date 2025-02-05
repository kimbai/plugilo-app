import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:plugilo/core/theme/colors.dart';
import 'package:validators/validators.dart';

class AppNetworkImage extends StatelessWidget {
  const AppNetworkImage({
    super.key,
    this.imageUrl,
    this.width,
    this.height,
    this.fit,
    this.placeholder,
    this.errorWidget,
  });

  final String? imageUrl;
  final double? width;
  final double? height;
  final BoxFit? fit;
  final Widget? placeholder;
  final Widget? errorWidget;

  @override
  Widget build(BuildContext context) {
    return isURL(imageUrl)
        ? CachedNetworkImage(
            imageUrl: imageUrl ?? '',
            placeholder: (context, url) => LoadingAnimationWidget.horizontalRotatingDots(color: AppColors.contentTertiary, size: 24),
            errorWidget: (context, url, error) => errorWidget ?? Container(),
            width: width,
            height: height,
            fit: fit,
          )
        : errorWidget ?? Container();
  }
}
