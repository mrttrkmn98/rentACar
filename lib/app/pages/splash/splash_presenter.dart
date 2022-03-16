import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';

import 'package:shopping_list/domain/repositories/user_repository.dart';
import 'package:shopping_list/domain/usecases/initialize_app.dart';

class SplashPresenter extends Presenter {
  late Function initializeAppOnComplete;
  late Function initializeAppOnError;

  final InitializeApp _initializeApp;

  SplashPresenter(
    UserRepository _userRepository,
  ) : _initializeApp = InitializeApp(_userRepository);

  void initializeApp() {
    _initializeApp.execute(_InitializeAppObserver(this));
  }

  @override
  void dispose() {
    _initializeApp.dispose();
  }
}

class _InitializeAppObserver extends Observer<void> {
  final SplashPresenter _presenter;

  _InitializeAppObserver(this._presenter);

  @override
  void onComplete() {
    _presenter.initializeAppOnComplete();
  }

  @override
  void onError(e) {
    _presenter.initializeAppOnError(e);
  }

  @override
  void onNext(_) {}
}
