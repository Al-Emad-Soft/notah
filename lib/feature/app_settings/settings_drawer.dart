import 'package:flutter/material.dart';
import 'package:notah/constants/app_lang.dart';
import 'package:notah/constants/app_themes.dart';
import 'package:notah/feature/app_settings/language_dropdown.dart';
import 'package:notah/feature/app_settings/theme_mode_dropdown.dart';

class SettingsDrawer extends StatelessWidget {
  const SettingsDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 250,
      backgroundColor: currTheme(context).colorScheme.background,
      child: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              "Settings".tr(),
              style: currTheme(context).textTheme.titleLarge,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          LanguageDropdown(),
          ThemeModeDropdown(),
        ],
      ),
    );
  }
}
