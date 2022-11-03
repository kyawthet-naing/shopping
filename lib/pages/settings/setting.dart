import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:shopping/routing/route_import.dart';
import 'package:shopping/theme/theme_widget.dart';
import 'package:shopping/theme/theme.dart';
import 'package:provider/provider.dart';

class Setting extends StatefulWidget {
  static const String route = "/setting";
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return ThemeWidget(
      builder: (_, theme, __) => Scaffold(
        appBar: AppBar(
          title: Text('setting'.tr()),
          centerTitle: true,
        ),
        body: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.theater_comedy),
              title: Text('theme'.tr()),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => MaterialPicker(
                    pickerColor: theme.primary,
                    onColorChanged: (color) {
                      var prov = Provider.of<AppTheme>(context, listen: false);
                      prov.changeTheme(color);
                    },
                  ),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.language),
              title: Text('language'.tr()),
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Column(
                    children: [
                      _buildLangTile(
                        context,
                        name: 'English',
                        locale: const Locale('en', 'US'),
                      ),
                      _buildLangTile(
                        context,
                        name: 'မြန်မာ',
                        locale: const Locale('my', 'MM'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildLangTile(BuildContext context,
      {required String name, required Locale locale}) {
    return ThemeWidget(
      builder: (_, theme, __) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
          leading: const Icon(Icons.translate),
          title: Text(name),
          onTap: () => context.setLocale(locale),
          trailing: locale.languageCode == context.locale.languageCode
              ? Icon(Icons.check, color: theme.primary)
              : null,
        ),
      ),
    );
  }
}
