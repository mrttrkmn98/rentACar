import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_list/app/constans.dart';
import 'package:shopping_list/app/widgets/animated_appbar/animated_down_appbar_container_widget.dart';
import 'package:shopping_list/app/widgets/animated_appbar/animated_up_appbar_container_widget.dart';

class DefaultAppBar extends StatefulWidget {
  final bool isScroll;

  DefaultAppBar(this.isScroll);

  @override
  State<DefaultAppBar> createState() => _DefaultAppBarState();
}

class _DefaultAppBarState extends State<DefaultAppBar> {
  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    return widget.isScroll == false
        ? Column(children: [
            AppBar(
                toolbarHeight: 80,
                centerTitle: true,
                backgroundColor: kprimaryColor,
                elevation: 0.0,
                leading: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(Icons.menu))),
            AnimatedDownAppbarContainerWidget(true)
          ])
        : Column(children: [
            AppBar(
                toolbarHeight: 80,
                centerTitle: true,
                backgroundColor: kprimaryColor,
                elevation: 0.0,
                leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu))),
            AnimatedUpAppbarContainerWidget()
          ]);
  }
}
