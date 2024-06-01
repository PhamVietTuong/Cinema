// ignore_for_file: avoid_print

import 'package:cinema_app/data/models/tickets.dart';

import '../data/injector.dart';
import '../data/models/ticket_option.dart';

abstract class TicketViewContract {
  void onLoadTicketComplete(List<Ticket> tickets);
  void onLoadTicketOptionComplete(List<TicketOption> ticketOptions);
  void onLoadTicketError();
}

class TicketPresenter {
  final TicketViewContract _view;
  late TicketRepository repository;

  TicketPresenter(this._view) {
    repository = Injector().getTicketRepository();
  }

  Future<void> fetchTicketOptions(String showtimeId, String roomId) async {
    try {
      List<TicketOption> ticketOptions = await repository.fetchTicketByRoomAndShowtimeId(showtimeId, roomId);
      _view.onLoadTicketOptionComplete(ticketOptions);
      //  _view.onLoadTheaterError();
    } catch (error) {
      // Xử lý lỗi
      print('Error fetching ticketOptions: $error');
      _view.onLoadTicketError();
    }
  }
}
