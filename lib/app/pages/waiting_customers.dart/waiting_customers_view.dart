import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/app/constans.dart';
import 'package:shopping_list/app/pages/waiting_customers.dart/waiting_customers_controller.dart';
import 'package:shopping_list/data/repositories/data_waiting_customers_repository.dart';

class WaitingCustomersView extends View {
  @override
  State<StatefulWidget> createState() {
    return _WaitingCustomersState(
      WaitingCustomersController(DataWaitingCustomersRepository()),
    );
  }
}

class _WaitingCustomersState
    extends ViewState<WaitingCustomersView, WaitingCustomersController> {
  _WaitingCustomersState(WaitingCustomersController controller)
      : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        key: globalKey,
        body: Container(
          width: size.width,
          height: size.height,
          color: black.withOpacity(.85),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(
                    parent: BouncingScrollPhysics(),
                  ),
                  child: ControlledWidgetBuilder<WaitingCustomersController>(
                    builder: (context, controller) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    top: padding.top + 10,
                                  ),
                                  width: size.width * .35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: kprimaryColor.withOpacity(.8),
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(
                                        15,
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      'Onay Bekleyenler : ' +
                                          controller.cars.length.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    controller.navigateToOperationsPage();
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      top: padding.top + 10,
                                    ),
                                    width: size.width * .08,
                                    height: 35,
                                    decoration: BoxDecoration(
                                      color: kprimaryColor.withOpacity(.8),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(
                                          15,
                                        ),
                                      ),
                                    ),
                                    child: Icon(
                                      Icons.arrow_forward,
                                      color: white,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 25),
                            controller.users == null
                                ? Container()
                                : Wrap(
                                    runSpacing: 30,
                                    spacing: 8,
                                    children: [
                                      for (var i = 0;
                                          i < controller.users!.length;
                                          i++)
                                        for (var index = 0;
                                            index <
                                                controller.users![i].rentedCars
                                                    .length;
                                            index++)
                                          Container(
                                            width: size.width * 0.45,
                                            decoration: BoxDecoration(
                                              color: Colors.white30,
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(20),
                                              ),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: CachedNetworkImage(
                                                    height: size.height * 0.2,
                                                    imageUrl: controller
                                                        .users![i]
                                                        .rentedCars[index]
                                                        .imageUrl,
                                                    placeholder:
                                                        (context, url) {
                                                      return Container(
                                                        width: size.width * 0.4,
                                                      );
                                                    },
                                                    errorWidget:
                                                        (context, url, error) =>
                                                            Icon(Icons.error),
                                                    fit: BoxFit.fitWidth,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    left: 5,
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      Container(
                                                        width: size.width * 0.4,
                                                        child: Text(
                                                          controller
                                                              .users![i]
                                                              .rentedCars[index]
                                                              .brand,
                                                          style:
                                                              defaultTextStyle(
                                                            white,
                                                          ),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: size.width * 0.4,
                                                        child: Text(
                                                          controller
                                                              .users![i]
                                                              .rentedCars[index]
                                                              .name,
                                                          maxLines: 1,
                                                          style:
                                                              carDefaultTextStyle(
                                                            white,
                                                          ),
                                                        ),
                                                      ),
                                                      SizedBox(height: 10),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                          left: 5,
                                                          right: 3,
                                                        ),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            Container(
                                                              child: Text(
                                                                  controller
                                                                          .users![
                                                                              i]
                                                                          .firstName
                                                                          .toString() +
                                                                      ' ' +
                                                                      controller
                                                                          .users![
                                                                              i]
                                                                          .lastName
                                                                          .toString(),
                                                                  style:
                                                                      TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                    color:
                                                                        black,
                                                                  )),
                                                            ),
                                                            Container(
                                                              width: 25,
                                                              height: 25,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color: Colors
                                                                    .green,
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  color: white,
                                                                  width: 0.5,
                                                                ),
                                                              ),
                                                              child: Icon(
                                                                Icons
                                                                    .done_rounded,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            Container(
                                                              width: 25,
                                                              height: 25,
                                                              decoration:
                                                                  BoxDecoration(
                                                                color:
                                                                    Colors.red,
                                                                shape: BoxShape
                                                                    .circle,
                                                                border:
                                                                    Border.all(
                                                                  color: white,
                                                                  width: 0.5,
                                                                ),
                                                              ),
                                                              child: Icon(
                                                                Icons.remove,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )
                                    ],
                                  )
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
