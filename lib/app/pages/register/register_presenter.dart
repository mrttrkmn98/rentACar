import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/repositories/authentication_repository.dart';
import 'package:shopping_list/domain/usecases/register_with_email.dart';

class RegisterPresenter extends Presenter {
  late Function registerWithEmailOnComplete;
  late Function registerWithEmailOnError;

  final RegisterWithEmail _registerWithEmail;

  RegisterPresenter(AuthenticationRepository _authenticationRepository)
      : _registerWithEmail = RegisterWithEmail(_authenticationRepository);

  void registerWithEmail(
      String firstName, String surname, String email, String password) {
    _registerWithEmail.execute(_RegisterWithEmailObserver(this),
        RegisterWithEmailParams(firstName, surname, email, password));
  }

  @override
  void dispose() {
    _registerWithEmail.dispose();
  }
}

class _RegisterWithEmailObserver extends Observer<void> {
  final RegisterPresenter _presenter;

  _RegisterWithEmailObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.registerWithEmailOnComplete();
  }

  @override
  void onError(e) {
    _presenter.registerWithEmailOnError(e);
  }

  @override
  void onNext(_) {}
}
