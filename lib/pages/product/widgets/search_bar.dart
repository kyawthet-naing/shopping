import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shopping/theme/theme_widget.dart';

class SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final Function(String) onSearch;
  final Function(String) onChanged;
  final Function onClear;
  const SearchBar(this.controller,
      {super.key,
      required this.onSearch,
      required this.onChanged,
      required this.onClear});

  @override
  Widget build(BuildContext context) {
    return ThemeWidget(
      builder: (_, theme, __) => Container(
        padding: const EdgeInsets.all(4),
        height: 60,
        color: theme.primary,
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.only(left: 10),
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: theme.white,
          ),
          child: Row(
            children: [
              Icon(
                Icons.search,
                color: theme.primary,
              ),
              Expanded(
                child: TextField(
                  textInputAction: TextInputAction.search,
                  onSubmitted: onSearch,
                  onChanged: onChanged,
                  controller: controller,
                  decoration: InputDecoration(
                    hintText: "search".tr(),
                    contentPadding: const EdgeInsets.all(6),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (controller.text.trim().isNotEmpty)
                InkWell(
                  onTap: () => onClear(),
                  child: SizedBox(
                    width: 40,
                    height: double.infinity,
                    child: Icon(
                      Icons.close,
                      color: theme.primary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
