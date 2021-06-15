import 'package:flutter/material.dart';
import 'package:launcher/launcher/launcher_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
      ),
      home: LauncherScreen(),
    );
  }
}
