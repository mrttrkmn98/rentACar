import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/app/constans.dart';

class AnimatedUpAppbarContainerWidget extends StatefulWidget {
  @override
  _AnimatedUpAppbarContainerWidgetState createState() =>
      _AnimatedUpAppbarContainerWidgetState();
}

class _AnimatedUpAppbarContainerWidgetState
    extends State<AnimatedUpAppbarContainerWidget>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    animation = Tween(begin: 0.0, end: 120.0).animate(controller)
      ..addListener(() {
        setState(() {});
      });
    controller.reverse(from: controller.upperBound);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        height: animation.value,
        child: Stack(children: [
          Container(
              padding: EdgeInsets.only(
                  left: kDefaultPadding,
                  right: kDefaultPadding,
                  bottom: kDefaultPadding * 2),
              height: (animation.value - 27).isNegative
                  ? size.height - 57
                  : animation.value - 27,
              decoration: BoxDecoration(
                  color: kprimaryColor,
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(36),
                      bottomRight: Radius.circular(36))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Araba Kirala!', style: mainTitleStyle(Colors.white)),
                    ClipRRect(
                        borderRadius: BorderRadius.circular(100000),
                        child: CachedNetworkImage(
                            imageUrl:
                                'https://media.istockphoto.com/vectors/car-keys-vector-id1202497889?k=20&m=1202497889&s=612x612&w=0&h=mKOpQWpd9xu0v66OurI5ZHPuKrYo1HNAWMPvsTrhYdo=',
                            placeholder: (context, url) =>
                                CircularProgressIndicator(
                                  color: kprimaryColor,
                                ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                            fit: BoxFit.fitWidth,
                            height: animation.value * 0.7))
                  ])),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                  padding: EdgeInsets.only(left: 20),
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  height: 54,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 50,
                            offset: Offset(0, 10),
                            color: kprimaryColor.withOpacity(0.25))
                      ]),
                  child: TextFormField(
                      decoration: InputDecoration(
                          hintText: 'Ara',
                          hintStyle:
                              TextStyle(color: kprimaryColor.withOpacity(0.5)),
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          suffixIcon: Icon(Icons.search,
                              color: kprimaryColor.withOpacity(0.5))))))
        ]));
  }
}
