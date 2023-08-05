// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notah/constants/app_themes.dart';
import 'package:notah/feature/app_settings/settings_drawer.dart';
import 'package:notah/feature/tasks/tasks_page.dart';
import 'package:notah/feature/home/top_app_bar.dart';
import 'package:notah/feature/notes/notes_page.dart';
import 'package:notah/view_models/page_navigation_controller.dart';

class HomePage extends StatelessWidget {
  static const String pageRoute = '/';
  const HomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SettingsDrawer(),
      backgroundColor: currTheme(context).colorScheme.background,
      appBar: AppBar(
        leading: new Container(),
        toolbarHeight: 120,
        elevation: 0,
        backgroundColor: currTheme(context).colorScheme.background,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  spreadRadius: 1,
                  blurRadius: 5,
                ),
              ],
              color: currTheme(context).primaryColor,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15),
              ),
            ),
            child: TopAppBar(),
          ),
        ),
      ),
      body: Consumer<PageNavigationController>(
        builder: (context, pageVM, child) => PageView(
          controller: pageVM.pageController,
          children: [
            TodosTasksPage(),
            NotesTasksPage(),
          ],
        ),
      ),
    );
  }
}
