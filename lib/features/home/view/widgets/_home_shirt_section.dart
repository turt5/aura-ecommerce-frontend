// import 'package:flutter/material.dart';

// class HomeShirtSection extends StatelessWidget {
//   const HomeShirtSection({super.key, required this.theme, required this.onTap, required this.title});

//   final ColorScheme theme;
//   final VoidCallback onTap;
//   final String title;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 560,
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                       color: theme.primary,
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(
//             height: 15,
//           ),
//           Expanded(
//             child: GridView.builder(
//               physics: const NeverScrollableScrollPhysics(),
//               gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//                 crossAxisCount: 2, // Number of columns in the grid
//                 crossAxisSpacing: 10.0, // Space between columns
//                 mainAxisSpacing: 10.0,
//                 mainAxisExtent: 240,
//               ),
//               itemCount: 4, // Total number of items
//               itemBuilder: (context, index) {
//                 return InkWell(
//                   onTap: onTap,
//                   borderRadius: BorderRadius.circular(15),
//                   child: Container(
//                     decoration: BoxDecoration(
//                       // color: theme.primary,
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: Column(
//                       children: [
//                         Expanded(child: Placeholder()),
//                         Container(
//                           height: 90,
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                               color: theme.primary.withOpacity(.1),
//                               borderRadius: const BorderRadius.only(
//                                   bottomLeft: Radius.circular(15),
//                                   bottomRight: Radius.circular(15))),
//                           padding:
//                               EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceAround,
//                             children: [
//                               Text(
//                                 'Premium Casual Shirt - Bradford',
//                                 maxLines: 2,
//                                 textAlign: TextAlign.center,
//                                 overflow: TextOverflow.ellipsis,
//                                 style: TextStyle(
//                                     color: theme.primary, fontSize: 12),
//                               ),
//                               Text(
//                                 'BDT 1650',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     color: theme.primary,
//                                     fontSize: 13),
//                               )
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
