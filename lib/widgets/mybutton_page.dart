import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
      color: colorButton,
      child: Text(
        text,
        style: GoogleFonts.poppins(
          fontSize: 12,
          color: Colors.white,
        ),
      ),
    );
  }
}
