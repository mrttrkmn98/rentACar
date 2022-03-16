import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/app/pages/login/login_view.dart';
import 'package:shopping_list/app/pages/register/register_presenter.dart';
import 'package:shopping_list/domain/repositories/authentication_repository.dart';

class RegisterController extends Controller {
  final RegisterPresenter _presenter;

  RegisterController(
    AuthenticationRepository _authenticationRepository,
  ) : _presenter = RegisterPresenter(_authenticationRepository);

  TextEditingController textController1 = TextEditingController();

  TextEditingController textController2 = TextEditingController();

  TextEditingController textController3 = TextEditingController();

  TextEditingController textController4 = TextEditingController();

  @override
  void dispose() {
    _presenter.dispose();
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();
    textController4.dispose();
    super.dispose();
  }

  @override
  void initListeners() {
    _presenter.registerWithEmailOnComplete = () {
      navigateToLoginPage();
    };

    _presenter.registerWithEmailOnError = (e) {};
  }

  @override
  void onInitState() {
    // TODO: implement onInitState
    super.onInitState();
  }

  void registerWithEmail(
      String firstName, String lastName, String email, String password) {
    _presenter.registerWithEmail(firstName, lastName, email, password);
    refreshUI();
  }

  void navigateToLoginPage() {
    Navigator.push(
        getContext(), MaterialPageRoute(builder: (context) => LoginView()));
  }
}
