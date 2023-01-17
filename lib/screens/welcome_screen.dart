import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat_starting/screens/login_screen.dart';
import 'package:flash_chat_starting/screens/registration_screen.dart';

import '../components/rounded_button.dart';
import '/constants.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
        // animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
        animation = ColorTween(begin: Colors.yellow.shade800, end: kBackgroundColor).animate(controller);
         controller.forward();
    // controller.addStatusListener((status) {
    //   if(status == AnimationStatus.completed){
    // controller.reverse(from: 1);

    //   }else if(status == AnimationStatus.dismissed){
    //         controller.forward();
    //   }
    // });

    controller.addListener((){
      setState(() {
        
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  height: 60,
                  child:
                      Hero(child: Image.asset('images/logo.png'), tag: "logo"),
                ),
                 DefaultTextStyle(
                  style: const TextStyle(
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                    color: Colors.white,
                  ),
                   child: AnimatedTextKit(
                    totalRepeatCount: 1,
                    animatedTexts: [
                      TypewriterAnimatedText('Flash Chat')
                      ],
                                 ),
                 ),
                
              ],
            ),
            const SizedBox(
              height: 48.0,
            ),
            RoundedButton(color: kLoginButtonColor, title: "Log In", callback: () {Navigator.pushNamed(context, LoginScreen.id);}),
            RoundedButton(color: kRegisterButtonColor, title: "Register", callback: () {Navigator.pushNamed(context, RegistrationScreen.id);}),
          ],
        ),
      ),
    );
  }
}
