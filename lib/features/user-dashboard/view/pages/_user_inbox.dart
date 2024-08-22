// import 'package:attira/features/home/view/widgets/_user_message.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// class UserInbox extends StatelessWidget {
//   const UserInbox({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context).colorScheme;

//     return Center(
//       child: InkWell(
//         borderRadius: BorderRadius.circular(10),
//         onTap: () {
//           Navigator.push(context, MaterialPageRoute(builder: (context)=>UserMessageView()));
//         },
//         child: Container(
//           height: 200,
//           width: 300,
//           decoration: BoxDecoration(
//               border: Border.all(
//                 color: theme.primary.withOpacity(.2),
//                 width: 2,
//               ),
//               borderRadius: BorderRadius.circular(10)),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.asset('assets/icon/message.png',color: theme.primary.withOpacity(.5),)
//                 ],
//               ),
//               const SizedBox(
//                 height: 20,
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text('Click here to chat with admin',style: TextStyle(
//                     color: theme.primary.withOpacity(.5)
//                   ),),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
