import 'package:flutter/cupertino.dart';
import 'package:shopping_list/app/constans.dart';

class TitleWithCustomUnderLineWidget extends StatelessWidget {
  final String text;

  TitleWithCustomUnderLineWidget(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 25,
        child: Stack(children: [
          Text(text,
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
          Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child:
                  Container(color: kprimaryColor.withOpacity(0.65), height: 5))
        ]));
  }
}
