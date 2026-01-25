import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:corporate_threat_detection/core/extension/extension.dart';
import 'package:corporate_threat_detection/core/icons/app_icons.dart';
import 'package:corporate_threat_detection/core/utils/utils.dart';

class EmptyWidget extends StatelessWidget {
  const EmptyWidget({super.key, required this.title, this.subtitle = "",this.lottiePath=AppIcons.emptyState});
  final String title;
  final String subtitle;
  final String lottiePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset(lottiePath),
          Column(
            spacing: he(5),
            children: [
              Text(
                title,
                style: context.textStyle.bodyBody.copyWith(
                  fontSize: 18
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                subtitle,
                style: context.textStyle.bodyBody,
                textAlign: TextAlign.center,
              ),
            ],
          ).paddingSymmetric(horizontal: wi(16)),
        ],
      ),
    ).paddingOnly(top: he(60));
  }
}
