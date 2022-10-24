import 'package:flutter/material.dart';

class RemoveScrollWave extends StatelessWidget {
  final Widget child;

  const RemoveScrollWave({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      
      onNotification: (scroll) {
        scroll.disallowIndicator();
        return false;
      },
      child: child,
    );
  }
}
