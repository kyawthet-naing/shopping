import 'package:intl/intl.dart';

class Reusable {
  static String priceFormat(num price) =>
      NumberFormat(',###.00', 'en_Us').format(price);
}
