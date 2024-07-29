import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:notah/feature/priced_tasks/models/priced_task_model.dart';
import 'package:notah/view_models/priced_tasks_view_model.dart';
import 'package:provider/provider.dart';
import 'package:notah/constants/app_const.dart';
import 'package:notah/feature/app_settings/models/settings_models.dart';
import 'package:notah/feature/notes/models/note_task_model.dart';
import 'package:notah/feature/tasks/models/todo_task_model.dart';
import 'package:notah/feature/notes_folders/task_folder_model.dart';
import 'package:notah/pages/home_page.dart';
import 'package:notah/view_models/lang_view_model.dart';
import 'package:notah/view_models/notes_view_model.dart';
import 'package:notah/view_models/page_navigation_controller.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notah/view_models/theme_view_model.dart';
import 'package:notah/view_models/todos_view_model.dart';
import 'constants/app_themes.dart';
import 'feature/notes_folders/tasks_folders_view_model.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final path = await getHivePath();
  await Hive.initFlutter(path);

  Hive.registerAdapter(TodoTaskModelAdapter());
  Hive.registerAdapter(NoteTaskModelAdapter());
  Hive.registerAdapter(TaskFolderModelAdapter());
  Hive.registerAdapter(SettingsModelAdapter());
  Hive.registerAdapter(PricedTaskModelAdapter());

  await Hive.openBox<NoteTaskModel>(kNotesTasksBox);
  await Hive.openBox<TodoTaskModel>(kTodosTasksBox);
  await Hive.openBox<TaskFolderModel>(kTasksFoldersBox);
  await Hive.openBox<PricedTaskModel>(kPricedTasksBox);
  await Hive.openBox<SettingsModel>(kSettingsBox);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PageNavigationController>(
          create: (_) => PageNavigationController(),
          lazy: true,
        ),
        ChangeNotifierProvider<TodosViewModel>(
          create: (_) => TodosViewModel(),
          lazy: true,
        ),
        ChangeNotifierProvider<NotesTasksViewModel>(
          create: (_) => NotesTasksViewModel(),
          lazy: true,
        ),
        ChangeNotifierProvider<PricedTasksViewModel>(
          create: (_) => PricedTasksViewModel(),
          lazy: true,
        ),
        ChangeNotifierProvider<TasksFoldersViewModel>(
          create: (_) => TasksFoldersViewModel(),
          lazy: true,
        ),
        ChangeNotifierProvider<ThemeViewModel>(
          create: (_) => ThemeViewModel(),
          lazy: true,
        ),
        ChangeNotifierProvider<LanguageViewModel>(
          create: (_) => LanguageViewModel(),
          lazy: true,
        ),
      ],
      builder: (context, child) => Consumer<ThemeViewModel>(
        builder: (context, themeVM, child) => Consumer<LanguageViewModel>(
          builder: (context, langVM, child) => MaterialApp(
            title: 'Notah',
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: List.generate(
              langVM.langs.length,
              (index) => langVM.langs[index].getLocale(),
            ),
            locale: langVM.currLocale,
            themeMode: themeVM.currThemeMode,
            darkTheme: darkTheme,
            theme: lightTheme,
            debugShowCheckedModeBanner: false,
            routes: {
              HomePage.pageRoute: (context) => HomePage(),
            },
            initialRoute: HomePage.pageRoute,
          ),
        ),
      ),
    );
  }
}
