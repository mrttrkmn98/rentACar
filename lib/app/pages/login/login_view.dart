import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_list/app/constans.dart';
import 'package:shopping_list/app/pages/login/login_controller.dart';
import 'package:shopping_list/data/repositories/data_authentication_repository.dart';

class LoginView extends View {
  @override
  State<StatefulWidget> createState() {
    return _LoginViewState(LoginController(DataAuthenticationRepository()));
  }
}

class _LoginViewState extends ViewState<LoginView, LoginController> {
  _LoginViewState(LoginController controller) : super(controller);

  @override
  Widget get view {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(children: [
          Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/login_picture.jpg'),
                      fit: BoxFit.cover,
                      colorFilter:
                          ColorFilter.mode(Colors.black38, BlendMode.darken)))),
          Scaffold(
              key: globalKey,
              resizeToAvoidBottomInset: true,
              backgroundColor: Colors.transparent,
              body: ControlledWidgetBuilder<LoginController>(
                  builder: (context, controller) {
                return Column(children: [
                  Flexible(
                      child: Center(
                          child: Text('Araç Kirala',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 60,
                                  fontWeight: FontWeight.bold)))),
                  _LoginPageTextFieldContainer(
                      size,
                      'email',
                      FontAwesomeIcons.envelope,
                      TextInputType.emailAddress,
                      TextInputAction.next,
                      controller.textController1),
                  _LoginPageTextFieldContainer(
                      size,
                      'sifre',
                      FontAwesomeIcons.lock,
                      TextInputType.visiblePassword,
                      TextInputAction.done,
                      controller.textController2),
                  Text('Sifremi Unuttum',
                      style: carDefaultTextStyle(Colors.white)),
                  InkWell(
                      onTap: () {
                        controller.signInWithEmail(
                            controller.textController1.text,
                            controller.textController2.text);
                      },
                      child: Container(
                          width: size.width * .8,
                          height: size.height * .08,
                          margin: EdgeInsets.only(bottom: 10, top: 15),
                          decoration: BoxDecoration(
                              color: Colors.blue[900],
                              borderRadius: BorderRadius.circular(16)),
                          child: Center(
                              child: Text('Giriş Yap',
                                  style: mainTitleStyle(Colors.white))))),
                  InkWell(
                      onTap: () {
                        controller.navigateToRegisterPage();
                      },
                      child: Container(
                          child: Text('Yeni Hesap Ac',
                              style: carDefaultTextStyle(Colors.white)),
                          decoration: BoxDecoration(
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1, color: Colors.white))))),
                  SizedBox(height: 10),
                ]);
              }))
        ]));
  }
}

class _LoginPageTextFieldContainer extends StatelessWidget {
  final Size size;
  final String text;
  final IconData icon;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final TextEditingController textEditingController;

  _LoginPageTextFieldContainer(
    this.size,
    this.text,
    this.icon,
    this.inputType,
    this.inputAction,
    this.textEditingController,
  );

  @override
  Widget build(BuildContext context) {
    return ControlledWidgetBuilder<LoginController>(
        builder: (context, controller) {
      return Container(
          width: size.width * .8,
          height: size.height * .08,
          margin: EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.circular(16)),
          child: Center(
              child: TextFormField(
                  cursorColor: Colors.white,
                  controller: textEditingController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      prefixIcon: FaIcon(icon, size: 30, color: Colors.white70),
                      hintText: text,
                      hintStyle:
                          carDefaultTextStyle(Colors.white.withOpacity(0.5))),
                  keyboardType: inputType,
                  textInputAction: inputAction)));
    });
  }
}
