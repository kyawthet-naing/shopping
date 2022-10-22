import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:shopping/providers/network_provider.dart';
import 'package:shopping/components/popup_view.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class NetworkListener extends StatefulWidget {
  final Widget child;
  const NetworkListener({Key? key, required this.child}) : super(key: key);

  @override
  State<NetworkListener> createState() => _NetworkListenerState();
}

class _NetworkListenerState extends State<NetworkListener> {
  late NetworkProvider networkProvider;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        networkProvider = Provider.of<NetworkProvider>(context, listen: false);
        connectionChecker();
      },
    );
    super.initState();
  }

  connectionChecker() {
    Timer.periodic(
      const Duration(seconds: 3),
      (timer) async {
        ///check connection
        var connectivityResult = await (Connectivity().checkConnectivity());
        if (connectivityResult == ConnectivityResult.none) {
          networkProvider.noInternet();
        } else {
          ///check connection data
          var hasData = await InternetConnectionChecker().hasConnection;
          if (hasData) {
            networkProvider.yesData();
          } else {
            networkProvider.noData();
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Consumer<NetworkProvider>(
        builder: (ctx, pd, child) => Stack(
          children: [
            widget.child,
            if (pd.networkStatus != NetworkStatus.yesData)
              Container(
                width: double.infinity,
                height: double.infinity,
                color: Colors.black.withOpacity(.5),
                child: Center(
                  child: PopupView(
                    title: getNetworkInfo(pd.networkStatus),
                    hideButton: true,
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }

  String getNetworkInfo(NetworkStatus status) {
    switch (status) {
      case NetworkStatus.checking:
        return "Checking internet connection...";

      case NetworkStatus.noInternet:
        return "Ohh!\nYou're Offline.\nCheck internet connection.";

      case NetworkStatus.noData:
        return "Ohh!\nConnection Fail !\nCheck internet connection.";

      default:
        return "Checking internet connection...";
    }
  }
}
