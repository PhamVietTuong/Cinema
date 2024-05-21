// ignore_for_file: avoid_print

import '../data/injector.dart';
import '../data/models/room.dart';
import '../data/models/ticket_option.dart';

abstract class RoomViewContract {
  void onLoadRoomComplete(List<Room> rooms);
  void onLoadTicketOptionComplete(List<TicketOption> ticketOptions);
  void onLoadRoomError();
}

class RoomPresenter {
  final RoomViewContract _view;
  late RoomRepository repository;

  RoomPresenter(this._view) {
    repository = Injector().getRoomRepository();
  }

  Future<void> fetchRooms() async {
    try {
      List<Room> rooms = await repository.fetchRooms();
      _view.onLoadRoomComplete(rooms);
      //  _view.onLoadTheaterError();
    } catch (error) {
      // Xử lý lỗi
      print('Error fetching rooms: $error');
      _view.onLoadRoomError();
    }
  }

  Future<void> fetchTicketOptionsBySeatIds(List<String> ids) async {
    String idsString = ids.join(',');
    try {
      List<TicketOption> ticketOptions =
          await repository.fetchTicketOptionsBySeatIds(idsString);
      _view.onLoadTicketOptionComplete(ticketOptions);
      //  _view.onLoadTheaterError();
    } catch (error) {
      // Xử lý lỗi
      print('Error fetching rooms: $error');
      _view.onLoadRoomError();
    }
  }

  Future<void> fetchRoomById(int id) async {
    try {
      Room room = await repository.fetchRoomById(id);
      _view.onLoadRoomComplete([room]);
      //  _view.onLoadTheaterError();
    } catch (error) {
      // Xử lý lỗi
      print('Error fetching rooms: $error');
      _view.onLoadRoomError();
    }
  }
}
