import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/app/constans.dart';
import 'package:shopping_list/app/pages/rented_cars/rented_cars_controller.dart';
import 'package:shopping_list/data/repositories/data_rent_a_car_repository.dart';
import 'package:shopping_list/data/repositories/data_user_repository.dart';
import 'package:shopping_list/domain/entities/car.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RentedCarsView extends View {
  @override
  State<StatefulWidget> createState() {
    return _RentedCarsViewState(
        RentedCarsController(DataRentACarRepository(), DataUserRepository()));
  }
}

class _RentedCarsViewState
    extends ViewState<RentedCarsView, RentedCarsController> {
  _RentedCarsViewState(RentedCarsController controller) : super(controller);

  @override
  Widget get view {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
        child: ControlledWidgetBuilder<RentedCarsController>(
            builder: (context, controller) {
          Size size = MediaQuery.of(context).size;
          double topPadding = 50;
          return Scaffold(
              key: globalKey,
              backgroundColor: kBackgroundColor,
              body: controller.rentedCars == null
                  ? Container(
                      color: kprimaryColor.withOpacity(0.5),
                      width: size.width,
                      height: size.height,
                      child: Center(
                          child:
                              CircularProgressIndicator(color: kprimaryColor)))
                  : controller.rentedCars!.isEmpty
                      ? Container(
                          color: kprimaryColor,
                          width: size.width,
                          height: size.height,
                          child: Center(
                              child: RotatedBox(
                                  quarterTurns: 1,
                                  child: Container(
                                      child: Text('KIRALADIGINIZ BIR ARAC YOK',
                                          style: carDefaultTextStyle(
                                              Colors.white))))))
                      : Container(
                          width: size.width,
                          height: size.height,
                          child: Column(children: [
                            Expanded(
                                child: Container(
                                    height: size.height,
                                    width: size.width,
                                    color: Colors.transparent,
                                    child: ListView(
                                        physics: AlwaysScrollableScrollPhysics(
                                            parent: BouncingScrollPhysics()),
                                        padding: EdgeInsets.all(0),
                                        scrollDirection: Axis.vertical,
                                        shrinkWrap: true,
                                        children: [
                                          for (var i = 0;
                                              i < controller.rentedCars!.length;
                                              i++)
                                            RotatedBox(
                                                quarterTurns: 1,
                                                child: _RentedCarItemWidget(
                                                    controller.rentedCars![i],
                                                    size,
                                                    topPadding))
                                        ])))
                          ])));
        }));
  }
}

class _RentedCarItemWidget extends StatefulWidget {
  final Car rentedCar;
  final Size size;
  final double padding;

  _RentedCarItemWidget(this.rentedCar, this.size, this.padding);

  @override
  __RentedCarItemWidgetState createState() => __RentedCarItemWidgetState();
}

class __RentedCarItemWidgetState extends State<_RentedCarItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Container(
            width: widget.size.height,
            height: widget.size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(widget.rentedCar.imageUrl),
                    fit: BoxFit.fill))),
        ControlledWidgetBuilder<RentedCarsController>(
            builder: (context, controller) {
          return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                    onTap: () {
                      controller.pop();
                    },
                    child: Container(
                        margin: EdgeInsets.only(right: 5, top: 5),
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black),
                        child: Icon(Icons.arrow_back,
                            color: Colors.white, size: 30))),
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    width: widget.size.height * 0.5,
                    height: widget.size.width * 0.33,
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(30))),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(widget.rentedCar.name,
                                          style: carDefaultTitleStyle(
                                              Colors.white)),
                                      Text(widget.rentedCar.brand,
                                          style:
                                              defaultTextStyle(Colors.white60))
                                    ]),
                                Column(children: [
                                  Text(widget.rentedCar.price.toString() + ' ₺',
                                      style:
                                          carDefaultTitleStyle(Colors.white60)),
                                  InkWell(
                                      child: Container(
                                          child: Icon(Icons.cancel,
                                              color: Colors.red)),
                                      onTap: () {
                                        controller.cancelRent(widget.rentedCar);
                                      })
                                ])
                              ]),
                          Container(
                              width: (widget.size.width - 20),
                              decoration: BoxDecoration(
                                  color: Colors.yellow[600],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(30))),
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FaIcon(FontAwesomeIcons.clock,
                                        color: Colors.black87, size: 20),
                                    SizedBox(height: 5),
                                    Text('Onay Bekleniyor',
                                        style: TextStyle(
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12))
                                  ]))
                        ]))
              ]);
        })
      ],
    );
  }
}
