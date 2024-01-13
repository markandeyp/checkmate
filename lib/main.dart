import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:checkmate/login.dart';

const appId = "devicesync-tqile";

void main() {
  final App atlasApp = App(AppConfiguration(appId));
  runApp(MyApp(
    atlasApp: atlasApp,
  ));
}

class MyApp extends StatelessWidget {
  final App atlasApp;

  const MyApp({super.key, required this.atlasApp});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(atlasApp: atlasApp),
    );
  }
}
