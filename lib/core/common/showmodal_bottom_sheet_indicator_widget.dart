import 'package:flutter/material.dart';
import 'package:corporate_threat_detection/core/extension/extension.dart';
import 'package:corporate_threat_detection/core/themes/colors/app_colors.dart';



Widget showModalBottomSheetIndicatorWidget(
        {required BuildContext context }) =>
    Align(
      alignment: Alignment.center,
      child: Container(
        width: 60,
        height: 4.5,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? const Color.fromARGB(255, 222, 220, 215)
              : AppColors.black,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
