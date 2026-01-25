import 'package:flutter/material.dart';
import 'package:corporate_threat_detection/core/extension/extension.dart';


class TabItem extends StatelessWidget {
  final String title;
  final int count;
  final bool isSelected;

  const TabItem({
    super.key,
    required this.title,
    required this.count,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) => Tab(
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: DefaultTextStyle.merge(
            style: context.textStyle.bodyBody.copyWith(fontSize: 14, inherit: false,),
            child: Text(
              title,
              style: context.textStyle.bodyBody.copyWith(
                fontSize: 14,
                color: isSelected ? Colors.white : null,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ).paddingAll(4),
          ),
        ),
      ],
    ),
  );
}
