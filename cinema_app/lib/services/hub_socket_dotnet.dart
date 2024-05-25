// ignore_for_file: avoid_print

import 'package:signalr_netcore/signalr_client.dart';

class SignalRService {
  final HubConnection hubConnection;

  SignalRService(this.hubConnection);

  void updateSeatStatus(Function(List<Object?>?) eventHandler) {
    hubConnection.on('UpdateSeatStatus', eventHandler);
  }

  void seatSelectionFeedback(Function(List<Object?>?) eventHandler) {
    hubConnection.on('SeatSelectionFeedback', eventHandler);
  }

  Future<void> selectSeat(String message) async {
    try {
      await hubConnection.invoke('SelectSeat', args: [message]);
      print('Seat selection request sent successfully');
    } catch (error) {
      print('Error occurred while sending seat selection request: $error');
    }
  }

  Future<void> deSelectSeat(String message) async {
    try {
      await hubConnection.invoke('DeSelectSeat', args: [message]);
      print('Seat deselection request sent successfully');
    } catch (error) {
      print('Error occurred while sending seat deselection request: $error');
    }
  }

  Future<void> confirmSelection(String message) async {
    try {
      await hubConnection.invoke('ConfirmSelection', args: [message]);
      print('Confirm Selection request sent successfully');
    } catch (error) {
      print('Error occurred while sending Confirm Selection request: $error');
    }
  }
}
