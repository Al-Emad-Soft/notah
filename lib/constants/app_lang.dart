import 'package:flutter/material.dart';
import 'package:notah/view_models/lang_view_model.dart';

Map<String, Map<String, String>> get keys => {
      Languages.en.localeCode(): {
        'Content': 'Content...',
        'Title': 'Title',
        'All': 'All',
        'Notes': 'Notes',
        'Tasks': 'Tasks',
        'Favorite': 'Favorite',
        'Favorites': 'Favorites',
        'Delete': 'Delete',
        'Mark as done': 'Mark as done',
        'Unmark as done': 'Unmark as done',
        'Subtasks': 'Subtasks',
        'Letters': 'Letters',
        'Settings': 'Settings',
        'dark': 'Dark',
        'light': 'Light',
        'system': 'System',
        'Arabic': 'Arabic',
        'English': 'English',
        'Share': 'Share',
        'Products': 'Products',
        'Warning': 'Warning',
        'Developed by': 'Developed by',
        'EMAD ARIF': 'EMAD ARIF',
        'Completed': 'Completed',
        'Delete Alert': 'Delete Alert',
        'Are you sure to delete all selected notes?':
            'Are you sure to delete all notes?'
      },
      Languages.ar.localeCode(): {
        'Content': 'المحتوى...',
        'Title': 'العنوان',
        'All': 'الكل',
        'Notes': 'ملاحظات',
        'Tasks': 'مهام',
        'Favorite': 'مفضلة',
        'Favorites': 'المفضلة',
        'Delete': 'حذف',
        'Mark as done': 'مكتملة',
        'Unmark as done': 'غير مكتملة',
        'Subtasks': 'المهام فرعية',
        'Letters': 'احرف',
        'Settings': 'الإعدادات',
        'dark': 'داكن',
        'light': 'ساطع',
        'system': 'النظام',
        'Arabic': 'العربية',
        'English': 'الانجليزية',
        'Share': 'مشاركة',
        'Warning': 'تحذير',
        'Products': 'الاصناف',
        'Developed by': 'تطوير بواسطة',
        'EMAD ARIF': 'عماد عارف',
        'Completed': 'مكتملة',
        'Delete Alert': 'تنبيه حذف',
        'Are you sure to delete all selected notes?':
            'هل انت متأكد من حذف جميع الملاحظات المحددة؟'
      }
    };

enum Languages {
  en,
  ar,
}

extension LanguagesExtension on Languages {
  String localeCode() {
    return this.name;
  }
}

late LanguageModel _langCode;

Locale get getLanguage => _langCode.getLocale();

bool isEnglish() {
  return getLanguage.languageCode == Languages.en.localeCode();
}

void setLanguage(LanguageModel model) {
  _langCode = model;
}

extension StringExtension on String {
  String tr() {
    return keys[getLanguage.languageCode]![this] ?? "Error";
  }
}
