import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat_starting/screens/chat_screen.dart';
import 'package:flash_chat_starting/services/auth_service.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/rounded_button.dart';
import '/constants.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  String errorMessage = "";
  bool errorOccurred = false, showSpinner = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
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
              Form(
                key: _keyForm,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Enter your Email", label: Text("Email")),
                                              controller: _emailController,
      
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (email) =>
                          email != null && EmailValidator.validate(email)
                              ? null
                              : "Please enter a valid Email!",
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    TextFormField(
                      decoration: kTextFieldDecoration.copyWith(
                          hintText: "Enter your password",
                          label: Text("Password")),
                          obscureText: true,
                                              controller: _passwordController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (password) =>
                          password != null && password.length > 5
                              ? null
                              : "Password should be at least 6 charechter!",
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 24.0,
              ),
              Visibility(
                visible: errorOccurred,
                child: Text(errorMessage, textAlign: TextAlign.center, style: TextStyle(color: Colors.red, fontSize: 16),),),
              RoundedButton(
                  color: kRegisterButtonColor,
                  title: "Register",
                  callback: () async {
                    if(_keyForm.currentState!.validate()){
                    try{
                      setState(() {
                        showSpinner = true;
                        errorOccurred = false;
                      });
                      await AuthService().createUserWithEmailAndPassword(
                        email: _emailController.text, 
                        password: _passwordController.text
                        ).then((value) {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, ChatScreen.id);
                      });

                      setState(() {
                        showSpinner = false;
                      });
                    }catch(e){
                      setState(() {
                        showSpinner = false;
                        errorOccurred = true;
                        errorMessage = e.toString().split("] ")[1];
                      });
                    }
                  }
                  }),
              const SizedBox(height: 12),
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
