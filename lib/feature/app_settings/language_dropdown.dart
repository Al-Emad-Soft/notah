import 'package:circle_flags/circle_flags.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:notah/constants/app_lang.dart';
import 'package:notah/view_models/lang_view_model.dart';
import 'package:notah/widgets/custom_dropdown.dart';

class LanguageDropdown extends StatelessWidget {
  const LanguageDropdown({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageViewModel>(
      builder: (context, langsVM, child) => CustomDropdown<LanguageModel>(
        items: langsVM.langs,
        value: langsVM.currLang,
        itemBuilder: (i) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              langsVM.langs[i].name.tr(),
            ),
            CircleFlag(langsVM.langs[i].code, size: 25),
          ],
        ),
        onChanged: (selectedLang) async {
          if (selectedLang == null) return;
          await langsVM.setLocale(selectedLang);
        },
      ),
    );
  }
}
