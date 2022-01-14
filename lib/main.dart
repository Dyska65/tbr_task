import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:test_tbr/page_input.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'),
        Locale('ru', 'RU'),
        Locale('uk', 'UA'),
      ],
      home: InputPhoneNumber(),
    );
  }
}
