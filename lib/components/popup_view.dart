import 'package:shopping/components/popup_listener.dart';
import 'package:flutter/material.dart';
import 'package:shopping/theme/theme_widget.dart';
import 'app_button.dart';

class PopupView extends StatelessWidget {
  final String title;
  final Function? confirm;
  final bool hideButton;
  const PopupView({
    super.key,
    required this.title,
    this.hideButton = false,
    this.confirm,
  });

  @override
  Widget build(BuildContext context) => Material(
        color: Colors.transparent,
        child: view(),
      );

  Widget view() {
    return ThemeWidget(
      builder: (_, theme, __) => Padding(
        padding: const EdgeInsets.all(10),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: theme.primary,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 18, color: theme.white),
                ),
                if (!hideButton) const SizedBox(height: 20),
                if (!hideButton)
                  Align(
                    alignment: Alignment.centerRight,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppButton(
                          height: 40,
                          width: 120,
                          borderRadius: BorderRadius.circular(10),
                          child: const Text('Cancel'),
                          onTap: () => PopupListenerState.hide(),
                        ),
                        const SizedBox(width: 10),
                        AppButton(
                          height: 40,
                          width: 120,
                          borderRadius: BorderRadius.circular(10),
                          child: const Text('Confirm'),
                          onTap: () {
                            if (confirm != null) confirm!();
                            PopupListenerState.hide();
                          },
                        ),
                      ],
                    ),
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
