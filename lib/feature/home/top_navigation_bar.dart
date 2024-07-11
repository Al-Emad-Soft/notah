import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notah/constants/app_lang.dart';
import 'package:notah/constants/app_themes.dart';
import 'package:notah/view_models/page_navigation_controller.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(15),
        ),
        child: Consumer<PageNavigationController>(
          builder: (context, pageVM, child) => NavigationBar(
            elevation: 0,
            selectedIndex: pageVM.currentPageIndex,
            backgroundColor: currTheme(context).primaryColor,
            labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
            destinations: [
              NavigationDestination(
                icon: Icon(
                  Icons.inventory_sharp,
                  //  color: currTheme(context).iconTheme.color,
                ),
                label: "Tasks".tr(),
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.grid_view_sharp,
                  // color: Colors.white,
                ),
                label: "Notes".tr(),
              ),
              NavigationDestination(
                icon: Icon(
                  Icons.view_list_rounded,
                  // color: Colors.white,
                ),
                label: "Priced".tr(),
              ),
            ],
            onDestinationSelected: (value) {
              pageVM.setPageIndexFromTab(value);
            },
          ),
        ),
      ),
    );
  }
}
