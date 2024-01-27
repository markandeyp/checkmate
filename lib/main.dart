import 'package:checkmate/services/user_service.dart';
import 'package:checkmate/splash.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

const appId = "devicesync-tqile";

void main() {
  final App atlasApp = App(AppConfiguration(appId));
  final UserService userService = UserService(atlasApp);
  runApp(MyApp(
    userService: userService,
  ));
}

class MyApp extends StatelessWidget {
  final UserService userService;

  const MyApp({super.key, required this.userService});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shopping List',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: SplashScreen(
        userService: userService,
      ),
    );
  }
}
