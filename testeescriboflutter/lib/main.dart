import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:testeescriboflutter/views/home_page.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var defaultColor = Colors.red;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Somadora de números',
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          brightness: Brightness.dark,
          primarySwatch: defaultColor,
        ),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}
