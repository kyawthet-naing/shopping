import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
/*
assets
└── translations
    ├── {languageCode}.{ext}                  //only language code
    └── {languageCode}-{countryCode}.{ext}    //or full locale code
*/
class Localization extends StatelessWidget {
  final Widget child;
  const Localization({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: const [
        Locale('en', 'US'),
        Locale('my', 'MM'),
      ],
      fallbackLocale: const Locale('en', 'US'),
      path: 'assets/translations',
      child: child,
    );
  }
}
