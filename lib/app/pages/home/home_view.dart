import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shimmer/shimmer.dart';
import 'package:shopping_list/app/constans.dart';
import 'package:shopping_list/app/pages/home/home_controller.dart';
import 'package:shopping_list/app/widgets/default_appbar.dart';
import 'package:shopping_list/app/widgets/drawer_widget.dart';
import 'package:shopping_list/app/widgets/title_with_custom_under_line_widget.dart';
import 'package:shopping_list/app/widgets/title_with_more_button_widget.dart';
import 'package:shopping_list/data/repositories/data_store_list_repository.dart';
import 'package:shopping_list/data/repositories/data_user_repository.dart';
import 'package:shopping_list/domain/entities/car.dart';

class HomeView extends View {
  @override
  State<StatefulWidget> createState() {
    return _HomeViewState(
        HomeController(DataStoreListRepository(), DataUserRepository()));
  }
}

class _HomeViewState extends ViewState<HomeView, HomeController> {
  _HomeViewState(HomeController controller) : super(controller);

  @override
  Widget get view {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarIconBrightness: Brightness.light),
        child: ControlledWidgetBuilder<HomeController>(
            builder: (context, controller) {
          Size size = MediaQuery.of(context).size;
          EdgeInsets padding = MediaQuery.of(context).padding;
          return Scaffold(
              backgroundColor: kBackgroundColor,
              key: globalKey,
              drawer: controller.user == null
                  ? Container()
                  : DrawerWidget(
                      controller.user!.firstName as String,
                      controller.user!.lastName as String,
                      controller.user!.email as String,
                      controller.signOut),
              body: Container(
                  width: size.width,
                  height: size.height,
                  child: NotificationListener<ScrollNotification>(
                      onNotification: (a) {
                        setState(() {
                          if (controller.isScroll == false &&
                              a.metrics.pixels > 300) {
                            controller.changeAppBarHeight();
                          }
                          if (controller.isScroll == true &&
                              a.metrics.pixels < 250) {
                            controller.changeAppBarHeightt();
                          }
                        });
                        return true;
                      },
                      child: Column(children: [
                        DefaultAppBar(controller.isScroll),
                        Expanded(
                            child: SingleChildScrollView(
                                physics: AlwaysScrollableScrollPhysics(
                                    parent: BouncingScrollPhysics()),
                                child: Column(children: [
                                  SizedBox(height: 25),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 15,
                                          right: kDefaultPadding,
                                          left: kDefaultPadding),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TitleWithCustomUnderLineWidget(
                                                'Önerilenler'),
                                            TitleWithMoreButton(
                                                text: 'Daha Fazla',
                                                press: () {})
                                          ])),
                                  Container(
                                      width: size.width,
                                      height: size.height * 0.28,
                                      child: controller.cars == null
                                          ? ListView(
                                              scrollDirection: Axis.horizontal,
                                              shrinkWrap: true,
                                              children: [
                                                  for (var i = 0; i < 3; i++)
                                                    _ShimmerredCarCartWidget(
                                                        size)
                                                ])
                                          : controller.cars!.isEmpty
                                              ? Container()
                                              : ListView(
                                                  physics: BouncingScrollPhysics(
                                                      parent:
                                                          AlwaysScrollableScrollPhysics()),
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  shrinkWrap: true,
                                                  children: [
                                                      for (var i = 4;
                                                          i <
                                                              controller
                                                                  .cars!.length;
                                                          i = i + 2)
                                                        _CarCartWidget(
                                                            controller.cars![i])
                                                    ])),
                                  Padding(
                                      padding: EdgeInsets.only(
                                          top: 15,
                                          bottom: 15,
                                          right: kDefaultPadding,
                                          left: kDefaultPadding),
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            TitleWithCustomUnderLineWidget(
                                                'Arabalar')
                                          ])),
                                  controller.cars == null
                                      ? Wrap(
                                          spacing: 20,
                                          runSpacing: 10,
                                          children: [
                                            for (var i = 0; i < 10; i++)
                                              _ShimmerredCarCartWidget(size)
                                          ],
                                        )
                                      : controller.cars!.isEmpty
                                          ? Container()
                                          : Wrap(
                                              spacing: 20,
                                              runSpacing: 10,
                                              children: [
                                                  for (var i = 0;
                                                      i <
                                                          controller
                                                              .cars!.length;
                                                      i++)
                                                    _CarCartWidget(
                                                      controller.cars![i],
                                                    )
                                                ]),
                                  SizedBox(height: padding.bottom + 20)
                                ])))
                      ]))));
        }));
  }
}

class _CarCartWidget extends StatelessWidget {
  final Car car;

  _CarCartWidget(this.car);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        margin: EdgeInsets.only(left: 10, right: 5, bottom: 5),
        width: size.width * 0.4,
        height: size.height * 0.26,
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  color: kprimaryColor.withOpacity(0.12),
                  offset: Offset(0, 10),
                  blurRadius: 10)
            ],
            borderRadius: BorderRadius.circular(15)),
        child: ControlledWidgetBuilder<HomeController>(
            builder: (context, controller) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                    child: Container(
                        height: size.height * 0.2,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(car.imageUrl),
                                fit: BoxFit.fitHeight),
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15)))),
                    onTap: () {
                      controller.navigateToCarPage(car);
                    }),
                SizedBox(height: 5),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(car.name.toUpperCase(),
                              style: defaultTextStyle(Colors.black),
                              maxLines: 1),
                          Text(car.price.toString() + '₺',
                              style: defaultTextStyle(kprimaryColor),
                              maxLines: 1)
                        ])),
                Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child:
                        Text(car.brand, style: defaultTextStyle(Colors.grey)))
              ]);
        }));
  }
}

class _ShimmerredCarCartWidget extends StatelessWidget {
  final Size size;

  _ShimmerredCarCartWidget(this.size);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 10, right: 5, bottom: 5),
        width: size.width * 0.4,
        height: size.height * 0.26,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15))),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          _BuildShimmer(Container(
              height: size.height * 0.2,
              width: size.width * 0.4,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15))))),
          SizedBox(height: 5),
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _BuildShimmer(Container(
                        height: size.height * 0.015,
                        width: size.width * 0.1,
                        color: Colors.grey)),
                    _BuildShimmer(Container(
                        height: size.height * 0.015,
                        width: size.width * 0.08,
                        color: Colors.grey))
                  ])),
          SizedBox(height: size.height * 0.01),
          _BuildShimmer(Container(
              margin: EdgeInsets.only(left: 8),
              height: size.height * 0.015,
              width: size.width * 0.15,
              color: Colors.grey))
        ]));
  }
}

class _BuildShimmer extends StatelessWidget {
  final Widget container;

  _BuildShimmer(this.container);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        child: container,
        baseColor: Colors.grey[400]!,
        highlightColor: Colors.grey[300]!);
  }
}
