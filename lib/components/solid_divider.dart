import 'package:flutter/material.dart';
import 'package:shopping/theme/theme.dart';

enum SolidDividerAxis { horizontal, vertical }

class SolidDivider extends StatelessWidget {
  final SolidDividerAxis axis;
  final double strokeWidth;
  final double width;
  final Color? color;
  const SolidDivider({
    super.key,
    this.axis = SolidDividerAxis.horizontal,
    this.width = double.infinity,
    this.strokeWidth = 1,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return axis == SolidDividerAxis.horizontal
        ? Container(
            width: width,
            height: strokeWidth,
            color: color ?? AppTheme().black,
          )
        : Container(
            width: strokeWidth,
            height: width,
            color: color ?? AppTheme().black,
          );
  }
}
