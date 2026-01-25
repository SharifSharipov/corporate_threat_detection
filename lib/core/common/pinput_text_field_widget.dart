import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:corporate_threat_detection/core/extension/extension.dart';
import 'package:corporate_threat_detection/core/themes/colors/app_colors.dart';
import 'package:corporate_threat_detection/core/utils/utils.dart';

class PinputTextFieldWidget extends StatefulWidget {
  const PinputTextFieldWidget({
    super.key,
    required this.pinController,
    required this.validator,
    required this.onChanged,
    required this.isValid,
  });

  final TextEditingController pinController;
  final String? Function(String?) validator;
  final ValueChanged<String> onChanged;
  final bool isValid;
  

  @override
  State<PinputTextFieldWidget> createState() => _PinputTextFieldWidgetState();
}

class _PinputTextFieldWidgetState extends State<PinputTextFieldWidget> {
  Brightness get themeController => Theme.of(context).brightness;

  Color getColorText() {
    return context.isDarkMode?AppColors.white: AppColors.black;
  }

  Color getColorDecoration() {
    return themeController == Brightness.light
        ? AppColors.fieldColor
        : AppColors.textColor;
  }

  PinTheme get defaultPinTheme => PinTheme(
    width: 55,
    height: 60,
    textStyle: TextStyle(
      fontSize: 18,
      color: getColorText(),
      fontWeight: FontWeight.w400,
    ),
    decoration: BoxDecoration(
      color: getColorDecoration(),
      borderRadius: AppUtils.kBorderRadius14,
    ),
  );

  PinTheme get successPinTheme => defaultPinTheme.copyWith(
    decoration: defaultPinTheme.decoration!.copyWith(
      border: Border.all(color: AppColors.textColor),
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Pinput(
      autofillHints:  const [AutofillHints.oneTimeCode],
      length: 6,
      controller: widget.pinController,
      onChanged: widget.onChanged,
      keyboardType: TextInputType.number,
      defaultPinTheme: defaultPinTheme,
      focusedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: context.isDarkMode
              ? AppColors.textColor
              : AppColors.fieldColor,
          borderRadius: AppUtils.kBorderRadius14,
          border: Border.all(
            color: AppColors.buttonColords.withValues(alpha: 0.3), 
            width: 2,
          ),
        ),
      ),
      submittedPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: AppColors.buttonColords.withValues(alpha: 0.3), 
          borderRadius: AppUtils.kBorderRadius14,
          border: Border.all(
            color: AppColors.buttonColords, 
            width: 2,
          ),
        ),
      ),

      errorPinTheme: defaultPinTheme.copyWith(
        decoration: BoxDecoration(
          color: getColorDecoration(),
          borderRadius: AppUtils.kBorderRadius14,
          border: Border.all(color: AppColors.c_F71E52, width: 2),
        ),
      ),

      pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
      validator: widget.validator,
    );
  }
}
