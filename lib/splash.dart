import 'package:checkmate/login.dart';
import 'package:checkmate/services/user_service.dart';
import 'package:checkmate/signup.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';

class SplashScreen extends StatelessWidget {
  final UserService userService;

  const SplashScreen({Key? key, required this.userService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.check_rounded,
                size: 100,
                color: Colors.greenAccent,
              ),
              const SizedBox(
                height: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20)),
                  onPressed: () async {
                    try {
                      final navigator = Navigator.of(context);
                      navigator.pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return LoginScreen(
                          userService: userService,
                        );
                      }));
                    } on RealmException catch (error) {
                      if (kDebugMode) {
                        print(
                            "Error while loading login screen. ${error.message}");
                      }
                    }
                  },
                  child: const Text("Login", style: TextStyle(fontSize: 20))),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20)),
                  onPressed: () async {
                    try {
                      final navigator = Navigator.of(context);
                      navigator.pushReplacement(
                          MaterialPageRoute(builder: (BuildContext context) {
                        return SignupScreen(
                          userService: userService,
                        );
                      }));
                    } on RealmException catch (error) {
                      if (kDebugMode) {
                        print(
                            "Error while loading signup screen. ${error.message}");
                      }
                    }
                  },
                  child: const Text("Signup", style: TextStyle(fontSize: 20)))
            ],
          ),
        ),
      ),
    );
  }
}
