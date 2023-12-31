import 'package:flutter/material.dart';

class Config {
  static const String API_URL = "http://charmbot.azurewebsites.net/api/v1";

  static final colors = {
    // dark
    'primary': Colors.black,
    'secondary': Colors.white,
    // light
    'primaryLight': Colors.white,
    'secondaryLight': Colors.black,
    // global
    'accent': Colors.pink,
    'danger': Colors.red[300],
  };
}
