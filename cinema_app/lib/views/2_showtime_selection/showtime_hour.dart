import 'package:cinema_app/style.dart';
import 'package:cinema_app/views/3_ticket_selection/ticket_type_screen.dart';
import 'package:flutter/material.dart';

class ShowTimeHour extends StatelessWidget {
  const ShowTimeHour({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    var styles = Styles();
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TicketTypeScreen(),
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
            child: Text(title,
                style: styles.titleTextStyle.copyWith(
                    fontWeight: FontWeight.normal, color: Colors.white))),
      ),
    );
  }
}
