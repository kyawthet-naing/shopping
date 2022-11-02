import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping/theme/theme.dart';

class ThemeWidget extends StatelessWidget {
  final Widget Function(
    BuildContext context,
    AppTheme theme,
    Widget? child,
  ) builder;
  const ThemeWidget({super.key, required this.builder});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppTheme>(builder: builder);
  }
}
