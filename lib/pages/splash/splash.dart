import 'package:flutter/material.dart';
import 'package:shopping/utils/images_name.dart';
import '/pages/product/product.dart';

class Splash extends StatefulWidget {
  static const String route = "/";
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    goHome();
    super.initState();
  }

  goHome() async {
    await Future.delayed(const Duration(seconds: 3)).then(
      (_) => Navigator.pushNamedAndRemoveUntil(
        context,
        Product.route,
        (route) => false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          ImagesName.shop,
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
