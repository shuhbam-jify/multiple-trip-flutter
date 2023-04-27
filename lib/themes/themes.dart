
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:multitrip_user/shared/shared.dart';

part 'dark_theme.dart';
part 'light_theme.dart';

ThemeData get themeData => AppEnvironment.isDark
    ? _DarkTheme.darkThemeData
    // ? _LightTheme.lightThemeData
    : _DarkTheme.darkThemeData;
