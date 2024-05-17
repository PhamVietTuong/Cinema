// ignore_for_file: avoid_print

import 'package:cinema_app/data/models/tickets.dart';

import '../data/injector.dart';

abstract class TicketViewContract {
  void onLoadTicketComplete(List<Ticket> tickets);
  void onLoadTicketError();
}

class TicketPresenter {
  final TicketViewContract _view;
  late TicketRepository repository;

  TicketPresenter(this._view) {
    repository = Injector().getTicketRepository();
  }

  Future<void> fetchTickets() async {
    try {
      List<Ticket> tickets = await repository.fetchTickets();
      _view.onLoadTicketComplete(tickets);
      //  _view.onLoadTheaterError();
    } catch (error) {
      // Xử lý lỗi
      print('Error fetching Tickets: $error');
      _view.onLoadTicketError();
    }
  }
}
