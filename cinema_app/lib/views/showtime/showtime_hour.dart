import 'package:cinema_app/style.dart';
import 'package:cinema_app/views/seat_selection/seat_selection_screen.dart';
import 'package:flutter/material.dart';

class ShowTimeHour extends StatelessWidget {
  const ShowTimeHour({super.key});

  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SeatSelectionScreen(),
            ));
      },
      child: Container(
        width: 75,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: styles.primaryColor,
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        child: Center(
            child: Text("23:40",
                style: styles.titleTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white))),
      ),
    );
  }
}
