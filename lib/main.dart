import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shopping/routing/route.dart';
import 'package:shopping/utils/color_utils.dart';
import 'package:shopping/utils/fonts_name.dart';
import 'package:shopping/providers/provider_widget.dart';

main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const Shoppy()));
}

class Shoppy extends StatelessWidget {
  const Shoppy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget(
      child: MaterialApp(
        title: "Shopping",
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: FontName.laila,
          scaffoldBackgroundColor: ColorUtils.background,
          appBarTheme: AppBarTheme(backgroundColor: ColorUtils.primary),
        ),
        onGenerateRoute: Routes.onGenerateRoute,
      ),
    );
  }
}
