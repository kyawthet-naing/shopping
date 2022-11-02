import 'package:flutter/material.dart';

class AppTheme extends ChangeNotifier {
  Color blackPoint2 = Colors.black.withOpacity(.2);
  Color white = Colors.white;
  Color red = Colors.redAccent;
  Color primary = const Color(0xFF581845);
  Color black = const Color(0xFF363740);
  Color background = const Color(0xffe9f5f9);

  changeTheme(Color color) {
    primary = color;
    notifyListeners();
  }
}
