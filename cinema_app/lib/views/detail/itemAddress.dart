import 'package:cinema_app/views/showtime/showtime_hour.dart';
import 'package:flutter/material.dart';

class ItemAddress extends StatelessWidget {
  const ItemAddress({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
            elevation: 4, 
          child: Container(
           width: MediaQuery.of(context).size.width,
           padding: const EdgeInsets.all(10),
            child: const Text("cinestar Đà lạt",style: TextStyle(fontSize: 18),),),
            
        ),
        const Text("Quảng trường Lâm Viên, P10,TP.Đà Lạt,Lâm Đồng",style: TextStyle(fontSize: 16),),
           const SizedBox(
            child: Wrap(
              spacing: 5,
              runSpacing: 5,
              children: [
                ShowTimeHour(),
                ShowTimeHour(),
                ShowTimeHour(),
                ShowTimeHour(),
                ShowTimeHour(),
                ShowTimeHour(),
                ShowTimeHour(),
                ShowTimeHour(),
                ShowTimeHour(),
                ShowTimeHour(),
              ],
            ),
          ),
      ],
    );
  }
}