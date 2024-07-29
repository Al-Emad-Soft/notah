import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notah/constants/app_lang.dart';
import 'package:notah/view_models/theme_view_model.dart';
import 'package:notah/widgets/custom_dropdown.dart';

class ThemeModeDropdown extends StatelessWidget {
  const ThemeModeDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeViewModel>(
      builder: (context, themeVM, child) => CustomDropdown<ThemeMode>(
        items: themeVM.themeModes,
        value: themeVM.currThemeMode,
        itemBuilder: (i) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              themeVM.themeModes[i].name.tr(),
            ),
            Icon(themeVM.getThemeModeIcon(themeVM.themeModes[i])),
          ],
        ),
        onChanged: (selectedTheme) {
          if (selectedTheme == null) return;
          themeVM.switchTheme(selectedTheme);
        },
      ),
    );
  }
}
