import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/app/pages/splash/splash_controller.dart';
import 'package:shopping_list/data/repositories/data_user_repository.dart';

class SplashView extends View {
  @override
  State<StatefulWidget> createState() {
    return _SplashViewState(SplashController(DataUserRepository()));
  }
}

class _SplashViewState extends ViewState<SplashView, SplashController> {
  _SplashViewState(SplashController controller) : super(controller);

  @override
  Widget get view {
    return Scaffold(key: globalKey, body: Center(child: FlutterLogo(size: 50)));
  }
}
