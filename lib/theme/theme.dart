import 'package:flutter/material.dart';
import 'package:shopping/utils/shared_pref.dart';
import 'package:shopping/utils/color_ext.dart';

class AppTheme extends ChangeNotifier {
  Color blackPoint2 = Colors.black.withOpacity(.2);
  Color white = Colors.white;
  Color red = Colors.redAccent;
  Color primary = const Color(0xFF581845);
  Color black = const Color(0xFF363740);
  Color background = const Color(0xffe9f5f9);
  final String _themeKEY = "THEMEKEY";

  ///get previous theme
  getPreviousTheme() {
    SharedPref.getData(key: _themeKEY).then(
      (color) {
        if (color != null) {
          changeTheme(HexColor.fromHex(color));
        }
      },
    );
  }

  changeTheme(Color color) {
    primary = color;
    notifyListeners();

    ///save theme
    SharedPref.setData(key: _themeKEY, value: color.toHex());
  }
}
