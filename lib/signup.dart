import 'package:checkmate/services/user_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:realm/realm.dart';
import 'package:checkmate/home.dart';
import 'package:checkmate/services/item_service.dart';

class SignupScreen extends StatelessWidget {
  final UserService userService;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  SignupScreen({Key? key, required this.userService}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.shopping_bag,
                  size: 100,
                  color: Colors.blueAccent,
                ),
                const SizedBox(
                  height: 30,
                ),
                const Text("Login",
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        hintText: "Email", border: OutlineInputBorder())),
                const SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                      hintText: "Password", border: OutlineInputBorder()),
                  obscureText: true,
                ),
                const SizedBox(
                  height: 15,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20)),
                    onPressed: () async {
                      try {
                        final navigator = Navigator.of(context);
                        User user = await userService.createUser(
                            emailController.text, passwordController.text);
                        navigator.pushReplacement(
                            MaterialPageRoute(builder: (BuildContext context) {
                          return HomeScreen(
                            itemService: ItemService(user),
                            userService: userService,
                          );
                        }));
                      } on RealmException catch (error) {
                        if (kDebugMode) {
                          print("Error during signup ${error.message}");
                        }
                      }
                    },
                    child: const Text("Signup", style: TextStyle(fontSize: 20)))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
