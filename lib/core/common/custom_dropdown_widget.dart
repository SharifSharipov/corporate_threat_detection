import 'package:flutter/material.dart';
import 'package:corporate_threat_detection/core/extension/extension.dart';
import 'package:corporate_threat_detection/core/themes/colors/app_colors.dart';
import 'package:corporate_threat_detection/core/utils/utils.dart';

class CustomDropdown extends FormField<String> {
  CustomDropdown({
    super.key,
    required List<String> items,
    String? initialValue,
    String? selectedItem,
    String label = "",
    double? maxHeight,
    ValueChanged<String?>? onChanged,
    Color? bgColor,
    super.validator,
  }) : super(
         initialValue: selectedItem ?? initialValue,
         builder: (FormFieldState<String> state) {
           return _CustomDropdownBody(
             items: items,
             label: label,
             maxHeight: maxHeight,
             selectedItem: state.value,
             errorText: state.errorText,
             bgColor: bgColor,
             onChanged: (value) {
               state.didChange(value);
               state.validate();
               onChanged?.call(value);
             },
           );
         },
       );
}

class _CustomDropdownBody extends StatefulWidget {
  final List<String> items;
  final String? selectedItem;
  final String label;
  final double? maxHeight;
  final String? errorText;
  final ValueChanged<String?> onChanged;
  final Color? bgColor;
  const _CustomDropdownBody({
    required this.items,
    this.selectedItem,
    required this.label,
    this.maxHeight,
    this.errorText,
    required this.onChanged,
    this.bgColor,
  });

  @override
  State<_CustomDropdownBody> createState() => _CustomDropdownBodyState();
}

class _CustomDropdownBodyState extends State<_CustomDropdownBody> {
  final GlobalKey _dropdownKey = GlobalKey();
  bool isOpen = false;
  String? selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.selectedItem;
  }

  @override
  void didUpdateWidget(_CustomDropdownBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.selectedItem != oldWidget.selectedItem) {
      selectedItem = widget.selectedItem;
    }
  }

  void _toggleMenu(BuildContext context) {
    if (_dropdownKey.currentContext == null) return;

    final RenderBox? renderBox =
        _dropdownKey.currentContext!.findRenderObject() as RenderBox?;

    if (renderBox == null) return;
    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    setState(() => isOpen = true);

    showMenu<String>(
      color: widget.bgColor ?? (context.isDarkMode
                ? const Color.fromARGB(255, 50, 47, 47)
                : AppColors.fieldColor),
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height,
        MediaQuery.of(context).size.width - (offset.dx + size.width),
        MediaQuery.of(context).size.height - (offset.dy + size.height),
      ),
      items: widget.items
          .map(
            (item) => PopupMenuItem<String>(
              value: item,
              padding: EdgeInsets.zero,
              child: Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Text(item),
              ),
            ),
          )
          .toList(),
      constraints: BoxConstraints(
        maxWidth: size.width,
        minWidth: size.width,
        maxHeight: widget.maxHeight ?? 300,
      ),
    ).then((value) {
      if (mounted) {
        setState(() => isOpen = false);
        if (value != null) {
          setState(() {
            selectedItem = value;
          });
          widget.onChanged(value);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool hasError = widget.errorText != null;

    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: he(8),
        children: [
          widget.label.isEmpty
              ? const SizedBox.shrink()
              : Text(
                  widget.label,
                  style: context.textStyle.bodyBody.copyWith(fontSize: 15),
                ),
          GestureDetector(
            key: _dropdownKey,
            onTap: () => _toggleMenu(context),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: widget.bgColor ?? (context.isDarkMode
                          ? const Color.fromARGB(255, 50, 47, 47)
                          : AppColors.fieldColor),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(
                  color: hasError
                      ? AppColors.c_F71E52.withValues(alpha: 0.5)
                      : (isOpen
                            ? const Color.fromARGB(255, 157, 159, 163)
                            : AppColors.fieldColor),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    selectedItem ?? "",
                    style: context.textStyle.bodyBody.copyWith(
                      fontSize: 15,
                      color: hasError
                          ? AppColors.c_F71E52.withValues(alpha: 0.5)
                          : null,
                    ),
                  ),
                  AnimatedRotation(
                    turns: isOpen ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: const Icon(Icons.keyboard_arrow_down),
                  ),
                ],
              ),
            ),
          ),
          if (hasError)
            Text(
              widget.errorText!,
              style: context.textStyle.bodySubheadline.copyWith(
                color: AppColors.c_F71E52.withValues(alpha: 0.5),
              ),
            ),
        ],
      ),
    );
  }
}
