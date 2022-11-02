import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:shopping/routing/route_import.dart';
import 'package:shopping/theme/theme.dart';

class Setting extends StatefulWidget {
  static const String route = "/setting";
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Setting'),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.theater_comedy),
            title: const Text('Theme'),
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: (context) => MaterialPicker(
                  pickerColor: AppTheme().primary,
                  onColorChanged: (color) {
                    Provider.of<AppTheme>(context, listen: false)
                        .changeTheme(color);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
