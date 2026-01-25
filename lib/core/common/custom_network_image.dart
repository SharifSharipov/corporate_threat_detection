
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:corporate_threat_detection/core/themes/colors/app_colors.dart';
import 'package:corporate_threat_detection/core/utils/utils.dart';


class CustomCachedNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;
  final double? radius;
  final double iconSize;
  final String? title;
  final bool border;
  final BoxFit? fit;
  final String? errorIcon;
  final BorderRadius? borderRadius;

  const CustomCachedNetworkImage(
      {super.key,
      required this.imageUrl,
      required this.height,
      required this.width,
      this.radius,
      this.border = false,
      this.iconSize = 60,
      this.title,
      this.fit,
      this.errorIcon,
      this.borderRadius,});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
        borderRadius: borderRadius ?? BorderRadius.circular(radius ?? 0),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          height: height,
          width: width,
          fit: fit ?? BoxFit.cover,
          placeholder: (context, url) => Shimmer.fromColors(
            period: const Duration(milliseconds: 800),
            baseColor: AppColors.textColorSub,
            highlightColor: AppColors.textColorSub.withValues(alpha: 0.3),
            child: CustomErrorWidget(
              height: height,
              width: width,
              border: border,
              iconSize: iconSize,
              title: title,
              errorIcon: errorIcon,
              borderRadius: borderRadius,
            ),
          ),
          errorWidget: (context, url, error) => CustomErrorWidget(
            height: height,
            width: width,
            border: border,
            iconSize: iconSize,
            title: title,
            
            errorIcon: errorIcon,
                    borderRadius: borderRadius
          ),
        ));
  }
}

class CustomErrorWidget extends StatelessWidget {
  final double height;
  final double width;
  final bool border;
  final double iconSize;
  final String? title;
  final String? errorIcon;
  final BorderRadius? borderRadius;

  const CustomErrorWidget({
    super.key,
    required this.height,
    required this.width,
    this.border = false,
    this.iconSize = 60,
    this.title,
    this.errorIcon,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    var theme=Theme.of(context);
    return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
            borderRadius: borderRadius ?? BorderRadius.circular(8),
            color:theme.colorScheme.surfaceContainerHighest,
            border: border ? Border.all(color: AppColors.textColorSub) : null),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight:
                height, // Ensure the content doesn't exceed available height
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
          /*    SvgPicture.asset(
                errorIcon ?? AppIcons.icNoImg,
                height: he(iconSize),
                fit: BoxFit.contain,
              ),*/
              if (title != null)
                Padding(
                  padding: AppUtils.kPaddingAll10,
                  child: Text(
                    title ?? "",
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                ),
            ],
          ),
        ));
  }
}