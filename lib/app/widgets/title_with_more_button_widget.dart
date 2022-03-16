import 'package:flutter/material.dart';
import 'package:shopping_list/app/constans.dart';

class TitleWithMoreButton extends StatelessWidget {
  final String text;
  final VoidCallback press;

  TitleWithMoreButton({required this.text, required this.press});

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: press,
        child: Container(
            width: 90,
            height: 30,
            decoration: BoxDecoration(
                color: kprimaryColor, borderRadius: BorderRadius.circular(50)),
            child: Center(
                child: Text(text,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w700)))));
  }
}
