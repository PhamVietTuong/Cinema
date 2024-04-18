import 'package:flutter/material.dart';

class SeatBox extends StatefulWidget {
  const SeatBox({super.key});

  @override
  State<SeatBox> createState() => _SeatBoxState();
}

class _SeatBoxState extends State<SeatBox> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Expanded(
            child: AspectRatio(
              //row: 18-1.4// 13-1.3// <10-1.0
              aspectRatio: 1.0, 
              child: Container(
                margin: const EdgeInsets.only(right: 3, bottom: 3),
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.amber)),
                child: Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(1.5),
                  decoration: const BoxDecoration(color: Colors.amber),
                  child: const Text(
                    "A01",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
