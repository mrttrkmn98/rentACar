import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/app/pages/login/login_presenter.dart';
import 'package:shopping_list/app/pages/register/register_view.dart';
import 'package:shopping_list/app/pages/splash/splash_view.dart';
import 'package:shopping_list/domain/repositories/authentication_repository.dart';

class LoginController extends Controller {
  final LoginPresenter _presenter;

  LoginController(AuthenticationRepository _authenticationRepository)
      : _presenter = LoginPresenter(_authenticationRepository);

  TextEditingController textController1 = TextEditingController();
  TextEditingController textController2 = TextEditingController();

  @override
  void dispose() {
    _presenter.dispose();
    textController1.dispose();
    textController2.dispose();
    super.dispose();
  }

  @override
  void initListeners() {
    _presenter.signInWithEmailOnComplete = () {
      Navigator.push(
          getContext(), MaterialPageRoute(builder: (context) => SplashView()));
    };
    _presenter.signInWithEmailOnError = (e) {};
  }

  @override
  void onInitState() {
    super.onInitState();
  }

  void signInWithEmail(String email, String password) {
    _presenter.signInWithEmail(email, password);
    refreshUI();
  }

  void navigateToRegisterPage() {
    Navigator.push(
        getContext(), MaterialPageRoute(builder: (context) => RegisterView()));
  }
}
