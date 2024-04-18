// import 'package:flutter/material.dart';

// class ComboCart extends StatefulWidget {
//   const ComboCart({super.key});

//   @override
//   State<ComboCart> createState() => _ComboCartState();
// }

// class _ComboCartState extends State<ComboCart> {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 5),
//       child: const SingleChildScrollView(
//         child: Row(
//           children: [ComboSelected(), ComboSelected()],
//         ),
//       ),
//     );
//   }
// }

// class ComboSelected extends StatelessWidget {
//   const ComboSelected({super.key});

//   @override
//   Widget build(BuildContext context) {
//     var wS = MediaQuery.of(context).size.width;
//     return Container(
//       margin: const EdgeInsets.only(right: 5),
//       child: Row(
//         children: [
//           SizedBox(
//               width: (wS) * 0.15,
//               child:
//                   const Image(image: AssetImage("assets/img_demo/Combo.png"))),
//           Column(children: [
//             Text("")
//           ],)
//         ],
//       ),
//     );
//   }
// }
