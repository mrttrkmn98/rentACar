import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/app/pages/home/home_view.dart';
import 'package:shopping_list/app/pages/login/login_view.dart';
import 'package:shopping_list/app/pages/operations/operations_view.dart';
import 'package:shopping_list/app/pages/splash/splash_presenter.dart';
import 'package:shopping_list/domain/repositories/user_repository.dart';

class SplashController extends Controller {
  final SplashPresenter _presenter;

  SplashController(
    UserRepository userRepository,
  ) : _presenter = SplashPresenter(userRepository);

  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void onInitState() {
    if (auth.currentUser != null) {
      _presenter.initializeApp();
    } else {
      Future.delayed(Duration.zero)
          .then((value) => Navigator.pushAndRemoveUntil(
              getContext(),
              MaterialPageRoute(
                builder: (context) => LoginView(),
              ),
              (route) => false));
    }
    super.onInitState();
  }

  @override
  void initListeners() {
    _presenter.initializeAppOnComplete = () {
      if (auth.currentUser!.uid == 'L7vTlZhDYiQbTfePVlhOyJXPify2') {
        Future.delayed(Duration.zero).then((value) =>
            Navigator.pushAndRemoveUntil(
                getContext(),
                MaterialPageRoute(builder: (context) => OperationsView()),
                (route) => false));
      } else {
        Navigator.pushAndRemoveUntil(
            getContext(),
            MaterialPageRoute(builder: (context) => HomeView()),
            (route) => false);
      }
    };

    _presenter.initializeAppOnError = (error) {};
  }
}
