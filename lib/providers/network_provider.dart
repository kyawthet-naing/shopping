import 'package:shopping/routing/route_import.dart';

enum NetworkStatus { noInternet, yesData, noData, checking }

class NetworkProvider extends ChangeNotifier {
  NetworkStatus networkStatus = NetworkStatus.checking;

  ///yes internet yes data
  yesData() {
    networkStatus = NetworkStatus.yesData;
    notifyListeners();
  }

  ///yes internet no data
  noData() {
    networkStatus = NetworkStatus.noData;
    notifyListeners();
  }

  checking() {
    networkStatus = NetworkStatus.checking;
    notifyListeners();
  }

  noInternet() {
    networkStatus = NetworkStatus.noInternet;
    notifyListeners();
  }
}
