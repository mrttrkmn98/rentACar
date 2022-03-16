import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/repositories/authentication_repository.dart';
import 'package:shopping_list/domain/usecases/sign_in_with_email.dart';

class LoginPresenter extends Presenter {
  late Function signInWithEmailOnComplete;
  late Function signInWithEmailOnError;

  final SignInWithEmail _signInWithEmail;

  LoginPresenter(AuthenticationRepository _authenticationRepository)
      : _signInWithEmail = SignInWithEmail(_authenticationRepository);

  void signInWithEmail(String email, String password) {
    _signInWithEmail.execute(
        _SignInWithEmailObserver(this), SignInWithEmailParams(email, password));
  }

  @override
  void dispose() {
    _signInWithEmail.dispose();
  }
}

class _SignInWithEmailObserver extends Observer<void> {
  final LoginPresenter _presenter;

  _SignInWithEmailObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.signInWithEmailOnComplete();
  }

  @override
  void onError(e) {
    _presenter.signInWithEmailOnError(e);
  }

  @override
  void onNext(_) {}
}
