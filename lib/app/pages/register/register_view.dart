import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_list/app/constans.dart';
import 'package:shopping_list/app/pages/register/register_controller.dart';
import 'package:shopping_list/data/repositories/data_authentication_repository.dart';

class RegisterView extends View {
  @override
  State<StatefulWidget> createState() {
    return _RegisterViewState(
        RegisterController(DataAuthenticationRepository()));
  }
}

class _RegisterViewState extends ViewState<RegisterView, RegisterController> {
  _RegisterViewState(RegisterController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return ControlledWidgetBuilder<RegisterController>(
        builder: (context, controller) {
      return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
              key: globalKey,
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              body: Stack(alignment: Alignment.topCenter, children: [
                Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                AssetImage('assets/images/login_picture.jpg'),
                            fit: BoxFit.cover,
                            colorFilter: ColorFilter.mode(
                                Colors.black38, BlendMode.darken)))),
                SingleChildScrollView(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                      SizedBox(height: padding.top + size.height * .03),
                      Container(
                          child: CircleAvatar(
                              radius: size.width * 0.2,
                              backgroundColor: Colors.blue,
                              child: FaIcon(FontAwesomeIcons.userPlus,
                                  color: Colors.white, size: 70))),
                      SizedBox(height: size.height * .05),
                      _LoginPageTextFieldContainer(
                          size,
                          'Ad',
                          TextInputType.name,
                          TextInputAction.next,
                          controller.textController1),
                      _LoginPageTextFieldContainer(
                          size,
                          'Soyad',
                          TextInputType.name,
                          TextInputAction.next,
                          controller.textController2),
                      _LoginPageTextFieldContainer(
                          size,
                          'email',
                          TextInputType.emailAddress,
                          TextInputAction.next,
                          controller.textController3),
                      _LoginPageTextFieldContainer(
                          size,
                          'sifre',
                          TextInputType.visiblePassword,
                          TextInputAction.done,
                          controller.textController4),
                      InkWell(
                          onTap: () {
                            controller.registerWithEmail(
                                controller.textController1.text,
                                controller.textController2.text,
                                controller.textController3.text,
                                controller.textController4.text);
                          },
                          child: Container(
                              width: size.width * .8,
                              height: size.height * .08,
                              margin: EdgeInsets.only(bottom: 10, top: 15),
                              decoration: BoxDecoration(
                                color: Colors.blue[900],
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Center(
                                  child: Text('Kayit Ol',
                                      style: mainTitleStyle(Colors.white)))))
                    ]))
              ])));
    });
  }
}

class _LoginPageTextFieldContainer extends StatelessWidget {
  final Size size;
  final String text;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController textEditingController;

  _LoginPageTextFieldContainer(this.size, this.text, this.inputType,
      this.inputAction, this.textEditingController);

  @override
  Widget build(BuildContext context) {
    return ControlledWidgetBuilder<RegisterController>(
        builder: (context, controller) {
      return Container(
          width: size.width * .8,
          height: size.height * .08,
          margin: EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 18),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.6),
              borderRadius: BorderRadius.circular(16)),
          child: Center(
              child: TextFormField(
                  cursorColor: Colors.white,
                  controller: textEditingController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: text,
                      hintStyle:
                          carDefaultTextStyle(Colors.white.withOpacity(0.5))),
                  keyboardType: inputType,
                  textInputAction: inputAction)));
    });
  }
}
