import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/app/constans.dart';
import 'package:shopping_list/app/pages/car/car_controller.dart';
import 'package:shopping_list/data/repositories/data_rent_a_car_repository.dart';
import 'package:shopping_list/data/repositories/data_user_repository.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:lottie/lottie.dart';

class CarView extends View {
  final Car car;

  CarView(this.car);

  @override
  State<StatefulWidget> createState() {
    return _CarViewState(
        CarController(DataRentACarRepository(), DataUserRepository(), car));
  }
}

class _CarViewState extends ViewState<CarView, CarController> {
  _CarViewState(CarController controller) : super(controller);

  @override
  Widget get view {
    return AnnotatedRegion(
        value: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
        child: ControlledWidgetBuilder<CarController>(
            builder: (context, controller) {
          Size size = MediaQuery.of(context).size;
          EdgeInsets padding = MediaQuery.of(context).padding;
          return Scaffold(
              key: globalKey,
              backgroundColor: kBackgroundColor,
              body: NotificationListener<ScrollNotification>(
                  onNotification: (a) {
                    if (a.metrics.pixels < -100) {
                      controller.closePage();
                    }
                    return false;
                  },
                  child: Container(
                      width: size.width,
                      height: size.height,
                      child: Column(children: [
                        Expanded(
                            child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(height: padding.top),
                                      _CarImageContainer(
                                          size: size, car: widget.car),
                                      Center(
                                          child: _CarBodyContainer(
                                              size: size, car: widget.car)),
                                      SizedBox(height: size.height * 0.1),
                                      Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Text(widget.car.name,
                                                    style: carDefaultTitleStyle(
                                                        Colors.black)),
                                                Text(widget.car.brand,
                                                    style: defaultTextStyle(
                                                        kprimaryColor))
                                              ])),
                                      SizedBox(height: 10),
                                      Row(children: [
                                        InkWell(
                                          child: _CarPageButton(
                                              size: size,
                                              textColor: Colors.white,
                                              backgroundColor: kprimaryColor,
                                              text: 'Şimdi Kirala'),
                                          onTap: () {
                                            controller.rentACar(widget.car);
                                          },
                                        ),
                                        _CarPageButton(
                                            size: size,
                                            textColor: Colors.black,
                                            backgroundColor: kBackgroundColor,
                                            text: 'Detaylar')
                                      ]),
                                      SizedBox(height: padding.bottom)
                                    ])))
                      ]))));
        }));
  }
}

class _CarImageContainer extends StatelessWidget {
  final Size size;
  final Car car;

  _CarImageContainer({required this.size, required this.car});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: size.width,
        height: size.height * 0.35,
        decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  offset: Offset(0, 10),
                  blurRadius: 50,
                  color: kprimaryColor.withOpacity(0.25))
            ],
            borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30))),
        child: ClipRRect(
            child: CachedNetworkImage(
                imageUrl: car.imageUrl,
                placeholder: (context, url) {
                  return Container();
                },
                errorWidget: (context, url, error) => Icon(Icons.error),
                fit: BoxFit.fill)));
  }
}

class _CarBodyContainer extends StatefulWidget {
  final Size size;
  final Car car;

  _CarBodyContainer({required this.size, required this.car});

  @override
  __CarBodyContainerState createState() => __CarBodyContainerState(car.color);
}

class __CarBodyContainerState extends State<_CarBodyContainer>
    with SingleTickerProviderStateMixin {
  final String color;

  __CarBodyContainerState(this.color);
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: AlignmentDirectional.bottomCenter, children: [
      Container(
          width: widget.size.width * 0.5,
          height: widget.size.height * 0.3,
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                offset: Offset(0, 10),
                blurRadius: 50,
                color: kprimaryColor.withOpacity(0.08))
          ]),
          child: Lottie.asset('assets/animations/car_animation_$color.json')),
      Container(
          child: Text(widget.car.price.toString() + '₺',
              style: carDefaultTitleStyle(kprimaryColor)))
    ]);
  }
}

class _CarPageButton extends StatefulWidget {
  final Size size;
  final Color backgroundColor;
  final Color textColor;
  final String text;

  _CarPageButton({
    required this.size,
    required this.textColor,
    required this.backgroundColor,
    required this.text,
  });

  @override
  __CarPageButtonState createState() => __CarPageButtonState();
}

class __CarPageButtonState extends State<_CarPageButton> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.size.width / 2,
        height: widget.size.height * 0.125,
        decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.only(topRight: Radius.circular(40))),
        child: Center(
            child: Text(widget.text,
                style: carDefaultTextStyle(widget.textColor))));
  }
}
