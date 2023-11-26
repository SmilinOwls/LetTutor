import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: const ColorScheme.light(primary: Colors.black),
    useMaterial3: true,
    primaryColor: Colors.blue[600],
    primarySwatch: Colors.blue,
    hintColor: Colors.grey.shade600,
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.blue),
      ),
    ),
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.grey.shade100,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Colors.blue[600],
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Colors.blue[600],
      ),
      displaySmall: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
      bodyMedium: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey[800],
      ),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.grey.shade100,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      surfaceTintColor: Colors.grey.shade100,
    ),
    iconTheme: IconThemeData(
      color: Colors.grey.shade800,
    ),
    cardColor: Colors.grey.shade100,
    cardTheme: CardTheme(
      surfaceTintColor: Colors.grey.shade100,
    ));

ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey.shade900,
    colorScheme: const ColorScheme.dark(primary: Colors.white),
    useMaterial3: true,
    primaryColor: Colors.blue[300],
    primarySwatch: Colors.blue,
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all(Colors.blue),
      ),
    ),
    hintColor: Colors.grey.shade400,
    appBarTheme: AppBarTheme(
      surfaceTintColor: Colors.grey.shade900,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: Colors.blue[600],
      ),
      displayMedium: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: Colors.blue[600],
      ),
      displaySmall: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w700,
      ),
      bodyLarge: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w800,
      ),
      bodyMedium: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.grey[200],
      ),
    ),
    dropdownMenuTheme: const DropdownMenuThemeData(
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    ),
    dialogTheme: DialogTheme(
      backgroundColor: Colors.grey.shade900,
    ),
    bottomAppBarTheme: BottomAppBarTheme(
      surfaceTintColor: Colors.grey.shade900,
    ),
    iconTheme: IconThemeData(
      color: Colors.grey.shade200,
    ),
    cardColor: Colors.grey.shade900,
    cardTheme: CardTheme(
      surfaceTintColor: Colors.grey.shade200.withOpacity(0.2),
    ));
