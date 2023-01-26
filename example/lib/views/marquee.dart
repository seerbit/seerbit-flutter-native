// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// class Marquee extends StatefulWidget {
//   const Marquee({super.key});

//   @override
//   State<Marquee> createState() => _MarqueeState();
// }

// class _MarqueeState extends State<Marquee> {
//   ScrollController sc = ScrollController();
//   late Timer time;
//   bool fa = true;

//   @override
//   void initState() {
//     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//       if (sc.hasClients) {
//         sc.animateTo(sc.position.maxScrollExtent,
//             duration: const Duration(seconds: 6), curve: Curves.linear);
//         time = Timer.periodic(const Duration(seconds: 5), (timer) {
//           if (fa) {
//             sc.animateTo(sc.position.maxScrollExtent,
//                 duration: const Duration(seconds: 5), curve: Curves.linear);
//             setState(() => fa = false);
//           } else {
//             sc.animateTo(sc.position.minScrollExtent,
//                 duration: const Duration(seconds: 5), curve: Curves.linear);
//             setState(() => fa = true);
//           }
//         });
//       }
//     });

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 875.h,
//       width: double.infinity,
//       color: Colors.white,
//       child: Column(
//         // mainAxisSize: MainAa,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//             child: SizedBox(
//               height: 100,
//               child: ListView(
//                   controller: sc,
//                   scrollDirection: Axis.horizontal,
//                   children: Colors.accents
//                       .map(
//                         (e) => Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Container(height: 100, width: 100, color: e),
//                         ),
//                       )
//                       .toList()),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
