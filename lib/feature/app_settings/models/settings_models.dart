// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'settings_models.g.dart';

@HiveType(typeId: 4)
class SettingsModel extends HiveObject {
  @HiveField(0)
  int languageId;
  @HiveField(1)
  int themeModeId;
  SettingsModel({
    required this.languageId,
    required this.themeModeId,
  });
}
