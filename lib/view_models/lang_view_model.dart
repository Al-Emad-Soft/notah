// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:notah/constants/app_const.dart';

import 'package:notah/constants/app_lang.dart';
import 'package:notah/feature/app_settings/models/settings_models.dart';

class LanguageModel {
  final Languages lang;
  final String name;
  final String code;
  LanguageModel({
    required this.lang,
    required this.name,
    required this.code,
  });

  Locale getLocale() {
    return Locale(lang.localeCode());
  }
}

class LanguageViewModel extends ChangeNotifier {
  final List<LanguageModel> _langs = [
    LanguageModel(lang: Languages.en, code: "us", name: 'English'),
    LanguageModel(lang: Languages.ar, code: "ae", name: 'Arabic'),
  ];
  List<LanguageModel> get langs => _langs;
  late LanguageModel _currLang = langs[0];
  LanguageViewModel() {
    loadLanguage();
  }
  final Box<SettingsModel> _box = Hive.box<SettingsModel>(kSettingsBox);

  LanguageModel get currLang => _currLang;
  Locale get currLocale => _currLang.getLocale();

  void loadLanguage() {
    if (_box.containsKey("settings")) {
      final found = _box.get("settings");
      final selectedLang = langs[found!.languageId];
      _currLang = selectedLang;
      setLanguage(selectedLang);
    } else {
      setLocale(_currLang);
    }
  }

  Future<void> setLocale(LanguageModel model) async {
    setLanguage(model);

    if (model == _currLang) return;
    _currLang = model;
    await _saveLanguage(model);

    notifyListeners();
  }

  Future<void> _saveLanguage(LanguageModel model) async {
    if (_box.containsKey("settings")) {
      final found = _box.get("settings");
      found!.languageId = langs.indexOf(model);
      await found.save();
    } else {
      await _box.put(
        "settings",
        SettingsModel(
          languageId: langs.indexOf(model),
          themeModeId: 0,
        ),
      );
    }
  }
}
