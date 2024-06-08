// ignore_for_file: avoid_print

import '../data/injector.dart';
import '../data/models/ticket_option.dart';

abstract class TicketViewContract {
  void onLoadTicketOptionComplete(List<TicketOption> ticketOptions);
  void onLoadError();
}

class TicketPresenter {
  // ignore: unused_field
  final TicketViewContract _view;
  late TicketRepository repository;

  TicketPresenter(this._view) {
    repository = Injector().getTicketRepository();
  }

  Future<void> fetchTicketOptions(String showtimeId, String roomId) async {
    try {
      List<TicketOption> ticketOptions =
          await repository.fetchTicketByRoomAndShowtimeId(showtimeId, roomId);
      _view.onLoadTicketOptionComplete(ticketOptions);
      //  _view.onLoadTheaterError();
    } catch (error) {
      // Xử lý lỗi
      print('Error fetching ticketOptions: $error');
      _view.onLoadError();
    }
  }
}
