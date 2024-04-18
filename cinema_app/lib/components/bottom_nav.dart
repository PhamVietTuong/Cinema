import 'package:cinema_app/views/home_screen.dart';
import 'package:cinema_app/views/1_threater_selection/theater_sceen.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  var index = 0;
  List<Widget> pages = [
    const HomePage(),
    const TheaterScreen(),
    const Center(
      child: Text("News"),
    ),
    const Center(
      child: Text("Profile"),
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //scaffold
        bottomNavigationBar: SizedBox(
          height: 52,
          child: CurvedNavigationBar(
            index: index,
            backgroundColor: Colors.blueGrey,
            items: const [
              CurvedNavigationBarItem(
                child:  Icon(Icons.home_outlined),
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.confirmation_num_outlined),
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.newspaper_outlined),
              ),
              CurvedNavigationBarItem(
                child: Icon(Icons.perm_identity),
              ),
            ],
            onTap: (newIndex) {
              setState(() {
                index = newIndex;
              });
            },
            animationCurve: Curves.ease,
            animationDuration: const Duration(milliseconds: 200),
            height: 50,
          ),
        ),
        body: Container(
          color: Colors.blueAccent,
          child: pages[index],
        ));
  }
}
