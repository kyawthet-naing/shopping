import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Reusable {
  
  static var statusBarHeight =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).padding.top;

  static String priceFormat(num price) =>
      NumberFormat(',###.00', 'en_Us').format(price);
}
