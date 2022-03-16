import 'package:flutter_clean_architecture/flutter_clean_architecture.dart';
import 'package:shopping_list/domain/entities/user.dart';
import 'package:shopping_list/domain/repositories/admin_repository.dart';
import 'package:shopping_list/domain/usecases/waiting_customers.dart';

class WaitingCustomersPresenter extends Presenter {
  late Function waitingCustomersOnNext;
  late Function waitingCustomersOnError;

  final WaitingCustomersApproval _waitingCustomers;

  WaitingCustomersPresenter(
    AdminRepository _adminRepository,
  ) : _waitingCustomers = WaitingCustomersApproval(_adminRepository);

  void getWaitingCustomers() {
    _waitingCustomers.execute(_WaitingCustomersObserver(this));
  }

  @override
  void dispose() {
    _waitingCustomers.dispose();
  }
}

class _WaitingCustomersObserver extends Observer<List<User>> {
  final WaitingCustomersPresenter _presenter;

  _WaitingCustomersObserver(this._presenter);

  @override
  void onComplete() {}

  @override
  void onError(e) {
    _presenter.waitingCustomersOnError(e);
  }

  @override
  void onNext(List<User>? response) {
    _presenter.waitingCustomersOnNext(response);
  }
}
