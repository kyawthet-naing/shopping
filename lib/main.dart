import 'package:easy_localization/easy_localization.dart';
import 'package:shopping/providers/provider_widget.dart';
import 'package:shopping/utils/fonts_name.dart';
import 'package:shopping/routing/route.dart';
import 'package:shopping/theme/theme.dart';
import 'localization/localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  ).then(
    (value) => runApp(
      const Localization(child: Shoppy()),
    ),
  );
}

class Shoppy extends StatelessWidget {
  const Shoppy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ProviderWidget(
      child: Consumer<AppTheme>(
        builder: (ctx, pd, child) {
          pd.getPreviousTheme();
          return MaterialApp(
            title: "Shopping",
            locale: context.locale,
            supportedLocales: context.supportedLocales,
            localizationsDelegates: context.localizationDelegates,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              fontFamily: FontName.laila,
              scaffoldBackgroundColor: pd.background,
              appBarTheme: AppBarTheme(backgroundColor: pd.primary),
              textSelectionTheme: TextSelectionThemeData(
                selectionColor: pd.primary.withOpacity(.3),
                selectionHandleColor: pd.primary,
                cursorColor: pd.primary,
              ),
            ),
            onGenerateRoute: Routes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
