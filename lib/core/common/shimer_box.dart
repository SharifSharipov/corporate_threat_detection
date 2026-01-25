import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:corporate_threat_detection/core/extension/extension.dart';
import 'package:corporate_threat_detection/core/themes/colors/app_colors.dart';

class ShimmerBox extends StatelessWidget {
  final double? height;
  final double? width;
  final double? borderRadius;
  final Widget? child;

  const ShimmerBox({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return FadeIn(
      duration: const Duration(milliseconds: 200),
      child: Shimmer.fromColors(
        period: const Duration(milliseconds: 1000),
        baseColor: context.isDarkMode ? AppColors.textColor : Colors.grey[300]!,
        highlightColor:context.isDarkMode
            ? const Color.fromARGB(255, 11, 60, 139)
            : Colors.white,
        child: child != null
            ? child!
            : SizedBox(
                height: height ?? 20,
                width: width ?? double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: AppColors.c_F71E52,
                    borderRadius: BorderRadius.circular(borderRadius ?? 16),
                  ),
                ),
              ),
      ),
    );
  }
}
