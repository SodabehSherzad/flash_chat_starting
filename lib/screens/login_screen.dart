import '../components/rounded_button.dart';
import '/constants.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
    static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 200.0,
              child: Hero(child: Image.asset('images/logo.png'), tag: "logo"),
            ),
            const SizedBox(
              height: 48.0,
            ),
            TextField(
              decoration: kTextFieldDecoration.copyWith(hintText: "Enter your Email"),
              onChanged: (value) {
                //Do something with the user input
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextField(
              decoration: kTextFieldDecoration.copyWith(hintText: "Enter your password"),
              onChanged: (value) {
                //Do something with the user input
              },
            ),
            const SizedBox(
              height: 24.0,
            ),
            RoundedButton(color: kLoginButtonColor, title: "Log In", callback: () {}),
            const SizedBox(height: 12),
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
