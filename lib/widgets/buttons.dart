import 'package:flutter/material.dart';

class Buttons extends StatelessWidget {
  final Color;
  final textcolor;
  final String buttonText;
  final buttonTapped;
  Buttons(
      {required this.Color,
      required this.buttonText,
      required this.textcolor,
      required this.buttonTapped});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: buttonTapped,
      child: Padding(
        padding: EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            color: Color,
            child: Center(
                child: Text(
              buttonText,
              style: TextStyle(color: textcolor, fontSize: 20),
            )),
          ),
        ),
      ),
    );
  }
}
