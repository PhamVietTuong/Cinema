import 'package:cinema_app/data/injector.dart';

import '../data/models/payment_request.dart';

abstract class PaymentViewContract {
  void onCreateURLCompelete(String url);
  void onError();
}

class PaymentPresenter {
  PaymentViewContract _view;
  late PaymentRepository _repository;
  PaymentPresenter(this._view) {
    _repository = Injector().getPaymentRepository();
  }

  Future<void> createPayment(PaymentRequest paymentRequest) async {
    try {
      String url = await _repository.createPayment(paymentRequest);
      _view.onCreateURLCompelete(url);
    } catch (error) {
      _view.onError();
    }
  }
}
