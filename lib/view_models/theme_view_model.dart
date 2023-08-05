import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notah/constants/app_const.dart';
import 'package:notah/feature/app_settings/models/settings_models.dart';

class ThemeViewModel extends ChangeNotifier {
  ThemeMode _mode = ThemeMode.dark;
  ThemeMode get currThemeMode => _mode;
  final Box<SettingsModel> box = Hive.box(kSettingsBox);

  List<ThemeMode> get themeModes =>
      [ThemeMode.dark, ThemeMode.light, ThemeMode.system];
  ThemeViewModel() {
    loadThemeMode();
  }
  Future<ThemeMode> switchTheme(ThemeMode mode) async {
    _mode = mode;
    await _saveThemeMode(mode);
    notifyListeners();
    return _mode;
  }

  void loadThemeMode() {
    if (box.containsKey("settings")) {
      _mode = themeModes[box.get("settings")!.themeModeId];
      notifyListeners();
    }
  }

  IconData getThemeModeIcon(ThemeMode mode) {
    if (mode == ThemeMode.dark)
      return Icons.dark_mode;
    else if (mode == ThemeMode.light)
      return Icons.light_mode;
    else
      return Icons.auto_mode;
  }

  Future<void> _saveThemeMode(ThemeMode mode) async {
    if (box.containsKey("settings")) {
      final found = box.getAt(0);
      found!.themeModeId = themeModes.indexOf(mode);
      await found.save();
    } else {
      await box.put(
        'settings',
        SettingsModel(languageId: 0, themeModeId: themeModes.indexOf(mode)),
      );
    }
  }
}
