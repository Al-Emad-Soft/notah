import 'package:flutter/material.dart';
import 'package:notah/constants/app_themes.dart';
import 'package:notah/widgets/custom_icon_button.dart';
import 'top_navigation_bar.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 50,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Positioned(
                    child: CustomIconButton(
                      icon: Icon(Icons.settings),
                      onPressed: () {
                        Scaffold.of(context).openDrawer();
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "نـــوتـــــــة",
                        style: currTheme(context).appBarTheme.titleTextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          TopNavigationBar(),
        ],
      ),
    );
  }
}
