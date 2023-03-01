import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_starting/screens/chat_screen.dart';
import 'package:flash_chat_starting/screens/login_screen.dart';
import 'package:flash_chat_starting/screens/registration_screen.dart';
 import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat_starting/services/auth_service.dart';
import 'firebase_options.dart';

import 'constants.dart';
import 'package:flutter/material.dart';
import '/screens/welcome_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(FlashChat());
}

class FlashChat extends StatelessWidget {
  FlashChat({super.key});
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthService().authStateChanges,
      builder:(context, snapshot) { 
        return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kBackgroundColor,
        ),
        routes: {
          WelcomeScreen.id: (context) => WelcomeScreen(),
          RegistrationScreen.id: (context) => RegistrationScreen(),
          LoginScreen.id: (context) => LoginScreen(),
          ChatScreen.id: (context) => ChatScreen(),
        },
    
        home: (AuthService().getCurrentUser != null) ? ChatScreen() : WelcomeScreen(),
      );
      }
    );
  }
}
