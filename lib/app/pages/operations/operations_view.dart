import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/app/pages/operations/operations_controller.dart';
import 'package:shopping_list/data/repositories/data_store_list_repository.dart';
import 'package:shopping_list/domain/entities/brand.dart';
import 'package:shopping_list/domain/entities/car.dart';

import '../../constans.dart';

class OperationsView extends View {
  @override
  State<StatefulWidget> createState() {
    return _OperationsViewState(
        OperationsController(DataStoreListRepository()));
  }
}

class _OperationsViewState
    extends ViewState<OperationsView, OperationsController> {
  _OperationsViewState(OperationsController controller) : super(controller);

  @override
  Widget get view {
    return ControlledWidgetBuilder<OperationsController>(
        builder: (context, controller) {
      Size size = MediaQuery.of(context).size;
      EdgeInsets padding = MediaQuery.of(context).padding;
      return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
              key: globalKey,
              resizeToAvoidBottomInset: false,
              backgroundColor: kBackgroundColor,
              body: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                          keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior.onDrag,
                          physics: BouncingScrollPhysics(
                              parent: AlwaysScrollableScrollPhysics()),
                          child: Container(
                              color: black.withOpacity(.85),
                              child: Column(children: [
                                Container(
                                    padding:
                                        EdgeInsets.only(top: 20 + padding.top),
                                    width: size.width,
                                    height: 200,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                'https://mir-s3-cdn-cf.behance.net/project_modules/disp/96fdb578684029.5cac4a000cece.gif'),
                                            fit: BoxFit.fill))),
                                SizedBox(height: 20),
                                _OperationsPageTextFieldContainer(
                                    size,
                                    'Araba Adı',
                                    TextInputType.name,
                                    TextInputAction.next,
                                    controller.textController1),
                                _OperationsPageTextFieldContainer(
                                    size,
                                    'Fotoğraf',
                                    TextInputType.name,
                                    TextInputAction.next,
                                    controller.textController2),
                                _OperationsPageTextFieldContainer(
                                    size,
                                    'Fiyat',
                                    TextInputType.name,
                                    TextInputAction.next,
                                    controller.textController3),
                                _OperationsPageTextFieldContainer(
                                    size,
                                    'Marka',
                                    TextInputType.name,
                                    TextInputAction.next,
                                    controller.textController4),
                                _OperationsPageTextFieldContainer(
                                    size,
                                    'Renk',
                                    TextInputType.name,
                                    TextInputAction.done,
                                    controller.textController5),
                                SizedBox(height: 20),
                                TextButton(
                                    onPressed: () {
                                      controller.addCarToStoreList(Car(
                                          id: '',
                                          name: controller.textController1.text,
                                          imageUrl:
                                              controller.textController2.text,
                                          price: int.tryParse(controller
                                              .textController3.text) as int,
                                          brand:
                                              controller.textController4.text,
                                          color:
                                              controller.textController5.text));
                                    },
                                    child: Container(
                                        height: 80,
                                        width: size.width / 1.5,
                                        decoration: BoxDecoration(
                                            color: Colors.white54,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Center(
                                            child: Text('Araba Ekle',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30,
                                                    color: black
                                                        .withOpacity(0.9)))))),
                                SizedBox(height: 20),
                                _OperationsPageTextFieldContainer(
                                    size,
                                    'Marka',
                                    TextInputType.name,
                                    TextInputAction.done,
                                    controller.textController6),
                                TextButton(
                                    onPressed: () {
                                      controller.addBrand(Brand(
                                          id: '',
                                          name: controller.textController6.text,
                                          cars: []));
                                    },
                                    child: Container(
                                        height: 80,
                                        width: size.width / 1.5,
                                        decoration: BoxDecoration(
                                            color: Colors.white54,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Center(
                                            child: Text('Marka Ekle',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 30,
                                                    color: black
                                                        .withOpacity(0.9)))))),
                                SizedBox(height: 20),
                                InkWell(
                                    onTap: () {
                                      controller.navigateToWaitingCustomers();
                                    },
                                    child: Container(
                                        height: 35,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                            color:
                                                kprimaryColor.withOpacity(0.8),
                                            borderRadius:
                                                BorderRadius.circular(0)),
                                        child: Center(
                                            child: Text('Onay Bekleyenlere Git',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                    color: white))))),
                                InkWell(
                                    child: Container(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 5),
                                        width: size.width,
                                        height: 35,
                                        decoration:
                                            BoxDecoration(color: Colors.red),
                                        child: Text('Çıkış Yap',
                                            textAlign: TextAlign.center,
                                            style: carDefaultTextStyle(
                                                Colors.white))),
                                    onTap: () {
                                      controller.signOut();
                                    })
                              ]))))
                ],
              )));
    });
  }
}

class _OperationsPageTextFieldContainer extends StatelessWidget {
  final Size size;
  final String text;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController textEditingController;

  _OperationsPageTextFieldContainer(this.size, this.text, this.inputType,
      this.inputAction, this.textEditingController);

  @override
  Widget build(BuildContext context) {
    return ControlledWidgetBuilder<OperationsController>(
        builder: (context, controller) {
      return Container(
          width: size.width * .8,
          height: size.height * .08,
          margin: EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 18),
          decoration: BoxDecoration(
              color: Colors.white30, borderRadius: BorderRadius.circular(16)),
          child: Center(
              child: TextFormField(
                  cursorColor: Colors.white,
                  controller: textEditingController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: text,
                      hintStyle: carDefaultTextStyle(Colors.white)),
                  keyboardType: inputType,
                  textInputAction: inputAction)));
    });
  }
}
