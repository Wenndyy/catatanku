import 'package:flutter/material.dart';

class MyButtonPage extends StatelessWidget {
  final String text;
  VoidCallback onPressed;
  MyButtonPage({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    const colorButton = Color(0xff9F73AB);
    return MaterialButton(
      onPressed: onPressed,
      child: Text(text),
      color: colorButton,
    );
  }
}
