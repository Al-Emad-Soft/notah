import 'dart:io';

import 'package:path_provider/path_provider.dart';

final String kNotesTasksBox = "notesTasks";
final String kTodosTasksBox = "todosTsasks";
final String kTasksFoldersBox = "tasksFolders";
final String kSettingsBox = "settings";
final String kHiveSubfolder = "Notah";

Future<String> getHivePath() async {
  final hiveDir = await getApplicationDocumentsDirectory();
  var hiveDb = Directory('${hiveDir.path}/${kHiveSubfolder}');

  return hiveDb.path;
}
