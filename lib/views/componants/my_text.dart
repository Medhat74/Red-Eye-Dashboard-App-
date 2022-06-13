import 'package:dashbord/src/app_color.dart';
import 'package:flutter/material.dart';

class MYText extends StatelessWidget {
  final Color textColor;
  final String text;
  final double size;
  final bool bold;


  MYText({required this.textColor, required this.text, required this.size, required this.bold});

  @override
  Widget build(BuildContext context) {
    return Text(
      text ,
      style: TextStyle(
          fontSize: size,
          color: textColor,
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
      ),
    );
  }
}
