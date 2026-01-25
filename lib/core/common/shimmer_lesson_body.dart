import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:corporate_threat_detection/core/extension/extension.dart';
import 'package:corporate_threat_detection/core/themes/colors/app_colors.dart';
import 'package:corporate_threat_detection/core/utils/utils.dart';

class ShimmerLessonBody extends StatelessWidget {
  final double width;
  final double? height;
  final BorderRadius borderRadius;
  const ShimmerLessonBody({
    super.key,
    this.width = double.infinity,
    this.height,
    this.borderRadius= AppUtils.kBorderRadius12,
  });

  @override
  Widget build(BuildContext context) => Shimmer.fromColors(
    baseColor: context.isDarkMode ? AppColors.c_2e3137 : Colors.grey[300]!,
    highlightColor: context.isDarkMode
        ? const Color.fromARGB(255, 11, 60, 139)
        : Colors.white,
    period: const Duration(milliseconds: 1000),
    child: SizedBox(
      height: height ?? he(35),
      width: width,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius:borderRadius,
          color: AppColors.black,
        ),
      ),
    ),
  );
}
