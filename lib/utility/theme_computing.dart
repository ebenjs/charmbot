import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config.dart';

class ThemeComputing {
  static Future<Brightness> getSpecificBrightness() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String theme = sharedPreferences.getString('theme') ?? 'dark';

    switch (theme) {
      case 'dark':
        return Brightness.dark;
      default:
        return Brightness.light;
    }
  }

  static Color? getThemeSpecificPrimaryColor(Brightness brightness) {
    switch (brightness) {
      case Brightness.dark:
        return Config.colors['primary'];
      default:
        return Config.colors['primaryLight'];
    }
  }

  static Color? getThemeSpecificSecondaryColor(Brightness brightness) {
    switch (brightness) {
      case Brightness.dark:
        return Config.colors['secondary'];
      default:
        return Config.colors['secondaryLight'];
    }
  }

  static String getThemeSpecificLogo(Brightness brightness) {
    switch (brightness) {
      case Brightness.dark:
        return 'logo.png';
      default:
        return 'logo-inversed.png';
    }
  }

  static String getThemeSpecificRegenerateIcon(Brightness brightness) {
    switch (brightness) {
      case Brightness.dark:
        return 'regenerate.png';
      default:
        return 'regenerate-inversed.png';
    }
  }

  static String getThemeSpecificShareIcon(Brightness brightness) {
    switch (brightness) {
      case Brightness.dark:
        return 'share.png';
      default:
        return 'share-inversed.png';
    }
  }

  static Future<String> changeTheme(BuildContext context) async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    final String currentTheme = sharedPreferences.getString('theme') ?? 'dark';
    final String newTheme = currentTheme == 'light' ? 'dark' : 'light';
    await sharedPreferences.setString('theme', newTheme);

    return newTheme;
  }
}
