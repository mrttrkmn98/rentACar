import 'package:flutter/material.dart';
import 'package:shopping_list/app/constans.dart';
import 'package:shopping_list/app/pages/rented_cars/rented_cars_view.dart';

class DrawerWidget extends StatelessWidget {
  final padding = EdgeInsets.symmetric(horizontal: 20);
  final String firstName;
  final String lastName;
  final String email;
  final Function() signOut;

  DrawerWidget(this.firstName, this.lastName, this.email, this.signOut);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Drawer(
        child: Material(
            color: kprimaryColor,
            child: Container(
                margin: EdgeInsets.only(top: 30, left: 10),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _ProfileCartWidget(firstName, lastName, email),
                      InkWell(
                        child: _DrawerMenuItemWidget(
                            text: 'Kiraladığım Araçlar', icon: Icons.vpn_key),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RentedCarsView()));
                        },
                      ),
                      _DrawerMenuItemWidget(
                          text: 'Favori Araçlarım', icon: Icons.favorite),
                      _DrawerMenuItemWidget(
                          text: 'Kişisel Bilgilerim',
                          icon: Icons.person_add_alt),
                      Container(
                          margin: EdgeInsets.only(right: 10, top: 30),
                          height: 0.5,
                          width: size.width,
                          color: Colors.white),
                      InkWell(
                          child: _DrawerMenuItemWidget(
                              text: 'Çıkış Yap',
                              icon: Icons.exit_to_app_outlined),
                          onTap: () {
                            signOut();
                          })
                    ]))));
  }
}

class _ProfileCartWidget extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;

  _ProfileCartWidget(this.firstName, this.lastName, this.email);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 15),
        height: 100,
        width: 300,
        child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
          Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 1),
                  image: DecorationImage(
                      image: NetworkImage(
                          'https://thumbs.dreamstime.com/b/handsome-man-black-suit-white-shirt-posing-studio-attractive-guy-fashion-hairstyle-confident-man-short-beard-125019349.jpg'),
                      fit: BoxFit.fill))),
          SizedBox(width: 15),
          Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(firstName + ' ' + lastName,
                    maxLines: 1, style: mainTitleStyle(Colors.white)),
                SizedBox(height: 8),
                Text(email, maxLines: 1, style: defaultTextStyle(Colors.white))
              ])
        ]));
  }
}

class _DrawerMenuItemWidget extends StatelessWidget {
  final String text;
  final IconData icon;

  _DrawerMenuItemWidget({required this.text, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 30),
        width: 200,
        height: 40,
        child: Row(children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 8),
          Text(text, style: defaultTextStyle(Colors.white))
        ]));
  }
}
