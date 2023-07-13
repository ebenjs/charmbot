import 'package:flutter/material.dart';

import '../../utility/theme_computing.dart';

class ThemeScreen {
  Brightness brightness = Brightness.dark;

  Future<Brightness> initializeTheme() async {
    await ThemeComputing.getSpecificBrightness().then((value) {
      brightness = value;
    });

    return brightness;
  }
}
