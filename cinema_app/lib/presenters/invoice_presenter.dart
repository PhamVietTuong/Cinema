// ignore_for_file: avoid_print
import 'package:cinema_app/data/injector.dart';
import 'package:cinema_app/data/models/invoice.dart';

abstract class InvoiceViewContract {
  void onLoadInvoiceComplete(List<Invoice> invoice);
  void onLoadError();
}

class InvoicePresenter {
  final InvoiceViewContract _view;
  late final InvoiceRepository _repository;

  InvoicePresenter(this._view) {
    _repository = Injector().getInvoiceRepository();
  }

  Future<void> fetchInvoice() async {
    try {
      final List<Invoice> invoices = await _repository.invoice();
      _view.onLoadInvoiceComplete(invoices);
     // print(invoices.first.movieName);
    } catch (error) {
     // print('Error fetching invoices: $error');
      _view.onLoadError();
    }
  }
}
