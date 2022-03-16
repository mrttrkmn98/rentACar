import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/app/constans.dart';

class DefaultNotificationBanner {
  final Widget icon;
  final String text;
  final Color color;
  final BuildContext context;

  DefaultNotificationBanner(this.icon, this.text, this.color, this.context);

  void show() {
    Flushbar(
        margin: EdgeInsets.all(8),
        borderRadius: BorderRadius.circular(8),
        flushbarPosition: FlushbarPosition.TOP,
        icon: Padding(
          padding: EdgeInsets.only(left: 15),
          child: icon,
        ),
        onTap: (flushbar) => flushbar.dismiss(),
        messageText: Padding(
            padding: EdgeInsets.only(left: 8, right: 9),
            child: Text(text,
                style: TextStyle(
                    color: white, fontSize: 14, fontWeight: FontWeight.w600))),
        duration: Duration(seconds: 2),
        backgroundColor: color,
        boxShadows: [
          BoxShadow(color: black, offset: Offset(0.0, 2.0), blurRadius: 3.0)
        ])
      ..show(context);
  }
}
