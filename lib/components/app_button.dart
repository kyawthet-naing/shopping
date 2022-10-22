import 'package:flutter/material.dart';
import 'package:shopping/utils/color_utils.dart';

class AppButton extends StatelessWidget {
  final double? width;
  final double? height;
  final Widget child;
  final Function onTap;
  final Color? color;
  final Color? hoveColor;
  final BorderRadiusGeometry? borderRadius;
  final EdgeInsetsGeometry? margin;

  const AppButton(
      {Key? key,
      required this.child,
      required this.onTap,
      this.color,
      this.margin,
      this.hoveColor,
      this.borderRadius,
      this.width,
      this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin ?? EdgeInsets.zero,
      child: Material(
        borderRadius: borderRadius,
        clipBehavior: Clip.antiAlias,
        color: color ?? ColorUtils.white,
        child: InkWell(
          hoverColor: hoveColor ?? ColorUtils.primary.withOpacity(.1),
          onTap: () => onTap(),
          child: Container(
              width: width ?? 50,
              height: height ?? 50,
              alignment: Alignment.center,
              child: child),
        ),
      ),
    );
  }
}
