import "package:flutter/material.dart";

import '../constants.dart';


class RoundedButton extends StatelessWidget {
  Color color;
  VoidCallback callback;
  String title;
  RoundedButton({required this.color, required this.title, required this.callback});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: callback,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style: const TextStyle(color: kWhiteColor),
          ),
        ),
      ),
    );
  }
}